class AddNetAmountToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_monetize :transactions, :amount_net, currency: { present: false }
  end
end
