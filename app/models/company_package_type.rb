class CompanyPackageType < ApplicationRecord
  belongs_to :package_type
  belongs_to :companies
end
