class CreateDeliveryPackages < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_packages do |t|
      t.references :delivery, foreign_key: true
      t.references :package_type, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
