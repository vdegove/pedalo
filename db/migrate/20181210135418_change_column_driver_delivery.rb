class ChangeColumnDriverDelivery < ActiveRecord::Migration[5.2]
  def change
    change_table :deliveries do |t|
      t.rename :name, :driver_name
      t.rename :phone, :driver_phone
      t.rename :photo, :driver_photo
    end
  end
end
