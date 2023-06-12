class RemoveCanceledFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :canceled, :boolean
  end
end
