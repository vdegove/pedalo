class CompleteValidation < ActiveModel::Validator
  def validate(record)
    # Todo : allow not to have a precise date
    if record.complete_before < record.complete_after
      record.errors[:base] << "Complete after has to be before complete before"
    # elsif record.complete_after < DateTime.now
    #   record.errors[:base] << "A Delivery starting date cannot be before now"
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


  # scope
  today = DateTime.now.midnight
  now = DateTime.now
  last_import = Delivery.last.created_at
  two_minutes_ago = last_import - 2.minutes
  scope :today, -> { where('complete_after > ? AND complete_after < ?', today, today.tomorrow) }
  scope :past, -> { where('complete_before < ?', today) }
  scope :upcoming, -> { where('complete_after > ?', today) }
  scope :delivered, -> { where(status: "Livré") }
  scope :not_delivered, -> { where('status = ? OR status = ?', "Enregistré", "Enlevé") }
  scope :in_process, -> { where(status: "Enlevé") }
  scope :enregistred, -> { where(status: "Enregistré") }
  scope :important, -> { where('status != ?', "Livré") }
  scope :recent, -> { where('created_at <= ? AND created_at > ?', last_import, two_minutes_ago) }



  def status?
    if self.picked_up_at.nil?
      self.status = "Enregistré"
      self.save
      return "Enregistré"
    elsif self.delivered_at.nil?
      self.status = "Enlevé"
      self.save
      return "Enlevé"
    else
      self.status = "Livré"
      self.save
      return "Livré"
    end
  end

  def date
    complete_after.to_date
  end

  # pg_search on deliveries' fields
  include PgSearch
  pg_search_scope :search_by_keyword,
    against: [ :recipient_phone, :recipient_name, :address, :complete_after, :complete_before, :status ],
    using: {
      tsearch: { prefix: true }
    }

  def push_to_onfleet
    task_pickup = Onfleet::Task.create(
      destination: {
        address: {
          unparsed: "#{company.address}, France"
        },
      },
      recipients: [{
        name: company.contact_name,
        phone: company.contact_phone
      }],
      notes: build_pickup_task_details,
      complete_after: complete_after.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      complete_before: complete_before.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      pickup_task: true
      )

    task_dropoff = Onfleet::Task.create(
      destination: {
        address: {
          unparsed: "#{address}, France"
        },
      },
      recipients: [{
        name: recipient_name,
        phone: recipient_phone
      }],
      notes: build_dropoff_task_details,
      complete_after: complete_after.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      complete_before: complete_before.to_datetime.strftime('%Q').to_i, # timestamp with ms precision
      dependencies: [task_pickup.id]
      )

    self.onfleet_task_pickup = task_pickup.id # can be called later with task = Onfleet::Task.get(delivery.onfleet_task_dropoff)
    self.tracking_url_pickup = task_pickup.tracking_url
    self.onfleet_task_dropoff = task_dropoff.id # can be called later with task = Onfleet::Task.get(delivery.onfleet_task_dropoff)
    self.tracking_url_dropoff = task_dropoff.tracking_url
    self.save
  end

  private

  def build_pickup_task_details
    "Ramasser pour : #{recipient_name}, #{address}

    Colisage :
    #{build_descr}"
  end

  def build_dropoff_task_details
    return "Client : #{company.name}

    Colisage :
    #{build_descr}"
  end

  def build_descr
    d = delivery_packages.map do |delivery_package|
      "#{delivery_package.package_type.name} : #{delivery_package.amount}"
    end
    return d.join('\n')
  end
end
