class DeliveriesController < ApplicationController

  def index
    @deliveries = policy_scope(Delivery)

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

  def new
    @delivery = Delivery.new
    authorize @delivery
  end

  def create
    @delivery = Delivery.create(deliveries_params)
    authorize @delivery
    @company = Company.first
    @delivery.company = @company
    if @delivery.save
      redirect_to deliveries_path
    else
      render :new
    end
  end

  def update
    @deliveries = Delivery.find(params[:id])
    @deliveries.update(deliveries_params)
  end

  private

  def deliveries_params
    params.require(:delivery).permit(:address, :company_id, :recipient_name, :recipient_phone, :complete_before,
                    :complete_after)
  end

end
