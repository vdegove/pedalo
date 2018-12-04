class DeliveriesController < ApplicationController

  def index
  end

  def new
    @delivery = Delivery.new
    authorize @delivery
  end

  def create
    @delivery = Delivery.create(deliveries_params)
    authorize @delivery
    @company = Company.find(params[:id])
    @delivery.company = @company
    if @delivery.save
      raise
      redirect_to deliveries_path
    else
      raise
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
                    :complete_after, :status)
  end

end
