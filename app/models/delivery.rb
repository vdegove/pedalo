class CompleteValidation < ActiveModel::Validator
  def validate(record)
    if record.complete_before < record.complete_after || record.complete_after < DateTime.now
      record.errors[:base] << "Start time has to be after now"
    end
  end
end


class Delivery < ApplicationRecord
  validates :recipient_name, presence: true
  validates :recipient_phone, presence: true, format: { with: /\A(?:(?:\+|00)33|0)*[1-9](?:[\s.-]*\d{2}){4}\z/}
  validates :address, presence: true
  validates :complete_before, presence: true
  validates :complete_after, presence: true

  validates_with CompleteValidation

  belongs_to :company
  has_many :delivery_packages

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  def status?
    if self.picked_up_at.nil?
      return "Enregisté"
    elsif self.delivered_at.nil?
      return "Enlevé"
    else
      return "Livré"
    end
  end

  # pg_search on deliveries' fields
  include PgSearch
  pg_search_scope :search_by_keyword,
    against: [ :recipient_phone, :recipient_name, :address, :complete_after, :complete_before, :status ],
    using: {
      tsearch: { prefix: true }
    }
end
