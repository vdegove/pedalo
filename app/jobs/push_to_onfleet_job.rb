class PushToOnfleetJob < ApplicationJob
  queue_as :default

  def perform(delivery_id)
    delivery = Delivery.find(delivery_id)
    delivery.push_to_onfleet
  end
end
