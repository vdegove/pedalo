class CompleteValidation < ActiveModel::Validator
  def validate(record)
    if record.complete_before < record.complete_after || record.complete_after < DateTime.now
      record.errors[:base] << "Start time has to be after now"
    end
  end
end


class Delivery < ApplicationRecord
  validates :recipient_name, presence: true
  # validates :recipient_phone, presence: true, format: { with: /^(\+33\s[1-9]{8})|(0[1-9]\s{8})$/ }
  validates :address, presence: true
  validates :complete_before, presence: true
  validates :complete_after, presence: true

  validates_with CompleteValidation

  belongs_to :company

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
end
