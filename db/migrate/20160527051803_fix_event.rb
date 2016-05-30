class FixEvent < ActiveRecord::Migration
  def change
    rename_column :events, :end_tiime, :end_time
  end
end
