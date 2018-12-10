require 'csv'

class DeliveriesController < ApplicationController
  skip_after_action :verify_authorized, only: [:bulk_new, :bulk_create]
  before_action :company_filter, only: [:index, :today, :past, :upcoming, :show, :update, :dashboard]

  def bulk_new
  end

  def index
    today = DateTime.now.midnight
    @period = "all"
    @all_deliveries = policy_scope(@user_deliveries)
    if params[:query].present?
      @deliveries = policy_scope(@user_deliveries.where("recipient_name ILIKE ?
        OR recipient_phone ILIKE ?
        OR address ILIKE ?
        OR status ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"))
    else
      @deliveries = policy_scope(@user_deliveries)
      case params[:period]
      when "past"
        @period = "past"
        @deliveries = @deliveries.past
      when "today"
        @period = "today"
        @deliveries = @deliveries.today
      when "upcoming"
        @period = "upcoming"
        @deliveries = @deliveries.upcoming
      end
    end
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
    @deliveries = @user_deliveries.find(params[:id])
    @deliveries.update(deliveries_params)
  end

  def show
    @delivery = @user_deliveries.find(params[:id])
    authorize @delivery
    @driver_name = @delivery.name

    @driver_phone = @delivery.phone

    @driver_photo = @delivery.photo

  end

  def dashboard
     @deliveries = policy_scope(@user_deliveries)
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

  def company_filter
    @user_deliveries = Delivery.where(company_id: current_user.company_id)
  end
end
