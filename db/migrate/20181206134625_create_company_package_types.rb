class CreateCompanyPackageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :company_package_types do |t|
      t.references :package_type, foreign_key: true
      t.references :companies, foreign_key: true

      t.timestamps
    end
  end
end
