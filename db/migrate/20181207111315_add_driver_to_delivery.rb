class AddDriverToDelivery < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :name, :string
    add_column :deliveries, :phone, :string
    add_column :deliveries, :photo, :string
  end
end
