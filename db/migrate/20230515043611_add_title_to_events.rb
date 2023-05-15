class AddTitleToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :title, :string
  end
end
