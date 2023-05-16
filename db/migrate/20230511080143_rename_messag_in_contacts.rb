class RenameMessagInContacts < ActiveRecord::Migration[7.0]
  def change
    rename_column :contacts, :messag, :message
  end
end
