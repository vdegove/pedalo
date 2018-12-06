require 'csv'

class DeliveriesController < ApplicationController
  skip_after_action :verify_authorized, only: [:bulk_new, :bulk_create]

  def bulk_new
  end

  def index
    if params[:query].present?
      @deliveries = policy_scope(Delivery.where("recipient_name ILIKE ?
        OR recipient_phone ILIKE ?
        OR address ILIKE ?
        OR status ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"))
    else
      @deliveries = policy_scope(Delivery)
    end
  end

  def today
    today = DateTime.yesterday + 1.day
    tomorrow = DateTime.tomorrow
    @deliveries = Delivery.where('complete_after > ? AND complete_after < ?', today, tomorrow)
    authorize @deliveries
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
    @count = 0
    CSV.foreach(params[:file].tempfile, headers: true) do |row|
      delivery = create_delivery(row)
      delivery.save
      @count += 1
    end
  end

  def update
    @deliveries = Delivery.find(params[:id])
    @deliveries.update(deliveries_params)
  end

  def show
    @delivery = Delivery.find(params[:id])
    authorize @delivery
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

end
