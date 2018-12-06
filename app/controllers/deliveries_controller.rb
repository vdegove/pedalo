require 'csv'

class DeliveriesController < ApplicationController
  skip_after_action :verify_authorized, only: :bulk_new
  before_action :company_filter, only: [:index, :today, :past, :upcoming, :show, :update]

  def bulk_new
  end

  def index
    if params[:query].present?
      @deliveries = policy_scope(user_deliveries.where("recipient_name ILIKE ?
        OR recipient_phone ILIKE ?
        OR address ILIKE ?
        OR status ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"))
    raise
    else
      @deliveries = policy_scope(@user_deliveries)
    end
  end

  def today
    today = DateTime.yesterday + 1.day
    tomorrow = DateTime.tomorrow
    @deliveries = @user_deliveries.where('complete_after > ? AND complete_after < ?', today, tomorrow)
    authorize @deliveries
  end

  def past
    today = DateTime.now
    @deliveries = @user_deliveries.where('complete_before < ?', today)
    authorize @deliveries
  end

  def upcoming
    today = DateTime.now
    @deliveries = @user_deliveries.where('complete_after > ?', today)
    authorize @deliveries
  end

  def today
    today = DateTime.yesterday + 1.day
    tomorrow = DateTime.tomorrow
    @deliveries = @user_deliveries.where('complete_after > ? AND complete_after < ?', today, tomorrow)
    authorize @deliveries
  end

  def bulk_create
    CSV.foreach(params[:file].tempfile, headers: true) do |row|
      delivery = create_delivery(row)
      authorize(delivery)
      delivery.save
    end
    # redirect_to root_path
  end

  def update
    @deliveries = @user_deliveries.find(params[:id])
    @deliveries.update(deliveries_params)
  end

  def show
    @delivery = @user_deliveries.find(params[:id])
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

  def company_filter
    @user_deliveries = Delivery.where(company_id: current_user.company_id)
  end

end
