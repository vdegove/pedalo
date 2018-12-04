class DeliveriesController < ApplicationController

  def index
    @deliveries = policy_scope(Delivery)
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
    @delivery.status = "Créer"
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

  def status
    # à utiliser pour afficher le status ?
  end

  private

  def deliveries_params
    params.require(:delivery).permit(:address, :company_id, :recipient_name, :recipient_phone, :complete_before,
                    :complete_after, :status)
  end

end
