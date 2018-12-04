require 'csv'

class DeliveriesController < ApplicationController
  skip_after_action :verify_authorized, only: :new
  def new
  end

  def create
    if params[:csv_file]
      CSV.foreach(params[:csv_file].tempfile, headers: true) do |row|
        delivery = current_user.company.deliveries.new(
          recipient_name: row["recipient_name"],
          recipient_phone: row["recipient_phone"],
          address: row["address"],
          complete_after: DateTime.parse(row["complete_after"]),
          complete_before: DateTime.parse(row["complete_after"])
          )
        authorize(delivery)

        if delivery.save
          redirect_to root_path
        else
          render :new
      end
    end
  end
end
