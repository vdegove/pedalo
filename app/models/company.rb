class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
<<<<<<< HEAD
  validates :address, presence: true
  validates :contact_name, presence: true
  # validates :contact_phone, format: { with: /^(\+33\s[1-9]{8})|(0[1-9]\s{8})$/ }
=======
  # validates :address, presence: true
  # validates :contact_name, presence: true
  validates :contact_phone, format: { with: /\A(?:(?:\+|00)33|0)*[1-9](?:[\s.-]*\d{2}){4}\z/, :allow_blank => true }
>>>>>>> origin/package-types

  has_many :deliveries
  has_many :users

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
