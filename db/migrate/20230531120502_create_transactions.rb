class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :recipient_id, null: false, foreign_key: { to_table: :users }
      t.references :payer_id, null: false, foreign_key: { to_table: :users }
      t.monetize :amount
      t.string :communication

      t.timestamps
    end
  end
end
