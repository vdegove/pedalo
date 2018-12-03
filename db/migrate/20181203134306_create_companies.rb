class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.float :longitude
      t.float :latitude
      t.string :contact_phone
      t.string :contact_name

      t.timestamps
    end
  end
end
