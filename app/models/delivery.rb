class Delivery < ApplicationRecord
  validates :recipient_name, presence: true
  validates :recipient_phone, presence: true, format: { with: /^(\+33\s[1-9]{8})|(0[1-9]\s{8})$/ }
  validates :address, presence: true
  validates :complete_before, presence: true
  validates :complete_after, presence: true

  belongs_to :company
end
