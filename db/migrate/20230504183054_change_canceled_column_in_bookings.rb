class ChangeCanceledColumnInBookings < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :canceled, :boolean, null: false, default: false
  end
end
