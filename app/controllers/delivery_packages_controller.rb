class DeliveryPackagesController < ApplicationController
  skip_after_action :verify_authorized, only: [:update, :create]
  skip_after_action :verify_policy_scoped, only: [:index] # TODO : ugly hack, remove that shit


  # def index
  #   @delivery_packages = []
  #   PackageType.all.each do |package_type|
  #     delivery_package = DeliveryPackage.where(delivery: params[:delivery_id], package_type: package_type)[0]
  #     if delivery_package
  #       @delivery_packages << delivery_package
  #     else
  #       @delivery_packages << DeliveryPackage.new(delivery_id: params[:delivery_id], amount: 0, package_type: package_type)
  #     end
  #   end
  # end

  def create
    delivery_package = DeliveryPackage.new(delivery_package_params)
    delivery_package.delivery = Delivery.find(params[:delivery_id])
    delivery_package.save
    redirect_to deliveries_test_bulk_create_path
  end

  # def edit
  #   @delivery_package = DeliveryPackage.find(params[:id])
  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end
  # TODO : see if relevant

  def update
    @delivery_package = DeliveryPackage.find(params[:id])
    @delivery_package.update(delivery_package_params)
    # respond_to do |format|
    #     format.html
    #     format.js
    #   end
    redirect_to deliveries_test_bulk_create_path
  end

  private

  def delivery_package_params
    params.require(:delivery_package).permit(:amount, :package_type_id)
  end
end
