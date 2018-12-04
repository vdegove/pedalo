class DeliveryPackage < ApplicationRecord
  belongs_to :delivery
  belongs_to :package_type
end
