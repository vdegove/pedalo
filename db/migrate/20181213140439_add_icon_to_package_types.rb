class AddIconToPackageTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :package_types, :icon, :string
  end
end
