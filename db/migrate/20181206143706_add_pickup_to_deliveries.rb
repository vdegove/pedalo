class AddPickupToDeliveries < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :onfleet_task_pickup, :string
    add_column :deliveries, :tracking_url_pickup, :string
  end
end
