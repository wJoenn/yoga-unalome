class RenameSessionsToEvents < ActiveRecord::Migration[7.0]
  def change
    rename_table :sessions, :events
  end
end
