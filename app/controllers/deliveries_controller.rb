require 'csv'

class DeliveriesController < ApplicationController
  skip_after_action :verify_authorized, only: :bulk_new

  def bulk_new
  end

  def index
    @deliveries = policy_scope(Delivery)
  end

  def past
    today = DateTime.now
    @deliveries = Delivery.where('complete_before < ?', today)
    authorize @deliveries
  end

  def upcoming
    today = DateTime.now
    @deliveries = Delivery.where('complete_after > ?', today)
    authorize @deliveries
  end

  def today
    today = DateTime.yesterday + 1.day
    tomorrow = DateTime.tomorrow
    @deliveries = Delivery.where('complete_after > ? AND complete_after < ?', today, tomorrow)
    authorize @deliveries
  end

  def bulk_create
    CSV.foreach(params[:csv_file].tempfile, headers: true) do |row|
      delivery = create_delivery(row)
      authorize(delivery)
      delivery.save
      push_to_onfleet(delivery)
    end
    redirect_to root_path
  end

  def update
    @deliveries = Delivery.find(params[:id])
    @deliveries.update(deliveries_params)
  end

  private

  def create_delivery(row)
    delivery = current_user.company.deliveries.new(
      recipient_name: row["recipient_name"],
      recipient_phone: row["recipient_phone"],
      address: row["address"],
      complete_after: DateTime.parse(row["complete_after"]),
      complete_before: DateTime.parse(row["complete_before"])
      )
    PackageType.all.each do |package_type|
      if row[package_type.name] && row[package_type.name] != "0"
        delivery.delivery_packages.new(
          amount: row[package_type.name],
          package_type: package_type
          )
      end
    end
    return delivery
  end


  def push_to_onfleet(delivery)
    Onfleet.api_key = ENV['ONFLEET_API_KEY']

    task = Onfleet::Task.create(
      destination: {
        address: {
          unparsed: "#{delivery.address}, France"
        },
      },
      recipients: [{
        name: delivery.recipient_name,
        phone: delivery.recipient_phone
      }],
      notes: build_onfleet_task_details(delivery),
      complete_after: delivery.complete_after.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      complete_before: delivery.complete_before.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      )

  end

  def build_onfleet_task_details(delivery)
    descrs = delivery.delivery_packages.map do |delivery_package|
      "#{delivery_package.package_type.name} : #{delivery_package.amount}"
    end
    return "Client : #{delivery.company.name}

    Colisage :
    #{descrs.join('\n')}"
  end
end
