class AddStatusToDelivery < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :status, :string
  end
end
