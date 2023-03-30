class RenamePassword < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :Password_digest, :password_digest
  end
end
