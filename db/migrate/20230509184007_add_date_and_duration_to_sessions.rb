class AddDateAndDurationToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :duration, :integer
  end
end
