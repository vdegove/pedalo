class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # validates :address, presence: true
  # validates :contact_name, presence: true
  validates :contact_phone, format: { with: /\A(?:(?:\+|00)33|0)*[1-9](?:[\s.-]*\d{2}){4}\z/, :allow_blank => true }

  has_many :deliveries
  has_many :users
  has_many :company_package_types
  has_many :package_types, through: :company_package_types

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
