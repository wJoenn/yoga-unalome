class AddPaymentsDetailsToBookings < ActiveRecord::Migration[7.0]
  def change
    add_monetize :bookings, :amount, currency: { present: false }

    add_column :bookings, :status, :string, default: "pending"
    add_column :bookings, :checkout_session_id, :string
  end
end
