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
  before_create :push_to_onfleet

  def status?
    if self.picked_up_at.nil?
      return "Enregisté"
    elsif self.delivered_at.nil?
      return "Enlevé"
    else
      return "Livré"
    end
  end

  private

  def push_to_onfleet
    task = Onfleet::Task.create(
      destination: {
        address: {
          unparsed: "#{address}, France"
        },
      },
      recipients: [{
        name: recipient_name,
        phone: recipient_phone
      }],
      notes: build_onfleet_task_details,
      complete_after: complete_after.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      complete_before: complete_before.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      )

    self.onfleet_task_dropoff = task.id # can be called later with task = Onfleet::Task.get(delivery.onfleet_task_dropoff)
    self.tracking_url_dropoff = task.tracking_url
  end

  def build_onfleet_task_details
    descrs = delivery_packages.map do |delivery_package|
      "#{delivery_package.package_type.name} : #{delivery_package.amount}"
    end
    return "Client : #{company.name}

    Colisage :
    #{descrs.join('\n')}"
  end

end
