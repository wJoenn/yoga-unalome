class UpdateBookingsSessionForeignKeyToEvent < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :session_id, :event_id
  end
end
