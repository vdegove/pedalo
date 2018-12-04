require 'csv'

class DeliveriesController < ApplicationController
  skip_after_action :verify_authorized, only: :new
  def new
  end

  def create
    CSV.foreach(params[:csv_file].tempfile, headers: true) do |row|
      delivery = create_delivery(row)
      authorize(delivery)
      delivery.save
    end
    redirect_to root_path
  end

  private

  def create_delivery(row)
    delivery = current_user.company.deliveries.new(
      recipient_name: row["recipient_name"],
      recipient_phone: row["recipient_phone"],
      address: row["address"],
      complete_after: DateTime.parse(row["complete_after"]),
      complete_before: DateTime.parse(row["complete_after"])
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
