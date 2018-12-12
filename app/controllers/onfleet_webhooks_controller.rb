class OnfleetWebhooksController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  skip_after_action :verify_authorized
  def task_completed
    render json: { message: "invalid token" } unless params[:token] == ENV['ONFLEET_WEBHOOK_TOKEN']
    if params[:check]
      render json: params[:check], status: :ok
    else

      delivery_pickup = Delivery.find_by onfleet_task_pickup: params[:taskId]
      if delivery_pickup
        delivery_pickup.picked_up_at = Time.at(params[:data][:task][:completionDetails][:time]/1000)
        delivery_pickup.save
      else
        delivery_dropoff = Delivery.find_by onfleet_task_dropoff: params[:taskId]
        if delivery_dropoff
          delivery_dropoff.delivered_at = Time.at(params[:data][:task][:completionDetails][:time]/1000)
          delivery_dropoff.save
        end
      end
      head :no_content
    end
  end

  def driver_assigned
    render json: { message: "invalid token" } unless params[:token] == ENV['ONFLEET_WEBHOOK_TOKEN']
    if params[:check]
      render json: params[:check], status: :ok
    else
      delivery = Delivery.find_by onfleet_task_pickup: params[:taskId]
      delivery = Delivery.find_by onfleet_task_dropoff: params[:taskId] if delivery.blank?

      if delivery
        delivery.driver_phone = params[:data][:worker][:phone]
        delivery.driver_photo = params[:data][:worker][:imageUrl]
        delivery.driver_name = params[:data][:worker][:name]
        delivery.save
      end
      head :no_content
    end
  end
end
