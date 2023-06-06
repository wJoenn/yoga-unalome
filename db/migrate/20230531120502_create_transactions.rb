class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :recipient, null: true, foreign_key: { to_table: :users }
      t.references :payer, null: true, foreign_key: { to_table: :users }
      t.string :recipient_name
      t.string :payer_name
      t.monetize :amount
      t.string :communication

      t.timestamps
    end
  end
end
