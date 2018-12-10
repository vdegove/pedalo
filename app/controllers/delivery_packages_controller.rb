class DeliveryPackagesController < ApplicationController
  skip_after_action :verify_authorized, only: [:edit, :update]

  def edit
    @delivery_package = DeliveryPackage.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @delivery_package = DeliveryPackage.find(params[:id])
    @delivery_package.update(delivery_package_params)
  end

  private

  def delivery_package_params
    params.require(:delivery_package).permit(:amount)
  end
end
