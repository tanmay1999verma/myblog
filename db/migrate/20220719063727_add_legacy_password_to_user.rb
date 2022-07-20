class AddLegacyPasswordToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :legacy_password, :boolean
  end
end
