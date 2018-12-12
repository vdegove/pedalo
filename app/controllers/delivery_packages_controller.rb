class DeliveryPackagesController < ApplicationController
  skip_after_action :verify_authorized, only: [:update]
  skip_after_action :verify_policy_scoped, only: [:index] # TODO : ugly hack, remove that shit

  # def edit
  #   @delivery_package = DeliveryPackage.find(params[:id])
  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end

  def index
    @delivery_packages = []
    PackageType.all.each do |package_type|
      delivery_package = DeliveryPackage.where(delivery: params[:delivery_id], package_type: package_type)[0]
      if delivery_package
        @delivery_packages << delivery_package
      else
        @delivery_packages << DeliveryPackage.new(delivery_id: params[:delivery_id], amount: 0, package_type: package_type)
      end
    end
  end

  def update
    @delivery_package = DeliveryPackage.find(params[:id])
    @delivery_package.update(delivery_package_params)
    respond_to do |format|
        format.html
        format.js
      end
  end
  private
  def delivery_package_params
    params.require(:delivery_package).permit(:amount)
  end
end
