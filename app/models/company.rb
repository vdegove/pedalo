class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, format: { with: /^(\+33\s[1-9]{8})|(0[1-9]\s{8})$/ }

  has_many :deliveries

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
