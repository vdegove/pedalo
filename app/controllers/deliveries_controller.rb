class DeliveriesController < ApplicationController

  def index
    @deliveries = policy_scope(Delivery)
  end

  def past
    today = DateTime.now
    # @deliveries = Delivery.where('today > complete_before')
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

  def show
    @delivery = Delivery.find(params[:id])
    authorize @delivery
  end

  private

  def deliveries_params
    params.require(:delivery).permit(:address, :company_id, :recipient_name, :recipient_phone, :complete_before,
                    :complete_after)
  end

end
