class RemoveEndTimeFromSession < ActiveRecord::Migration[7.0]
  def change
    remove_column :sessions, :end_time, :datetime
  end
end
