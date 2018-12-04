class AddPickedUpAtToDelivery < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :picked_up_at, :string
    add_column :deliveries, :delivered_at, :string
  end
end
