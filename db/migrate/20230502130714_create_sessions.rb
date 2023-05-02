class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :address
      t.time :start_time
      t.time :end_time
      t.integer :capacity

      t.timestamps
    end
  end
end
