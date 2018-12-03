class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.references :company, foreign_key: true
      t.string :recipient_name
      t.string :recipient_phone
      t.string :address
      t.float :longitude
      t.float :latitude
      t.datetime :complete_after
      t.datetime :complete_before

      t.timestamps
    end
  end
end
