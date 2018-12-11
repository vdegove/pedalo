class ChangeOnfleetTimestampsToDateTime < ActiveRecord::Migration[5.2]
  def change
    change_column :deliveries, :picked_up_at, 'timestamp USING CAST(picked_up_at AS timestamp)'
    change_column :deliveries, :delivered_at, 'timestamp USING CAST(delivered_at AS timestamp)'
  end
end
