class AddOnfleetToDeliveries < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :onfleet_task_dropoff, :string
    add_column :deliveries, :tracking_url_dropoff, :string
  end
end
