class AddEncryptedPasswordToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :encrypted_password, :string, default: '', null: false
    remove_column :admins, :password_digest
  end
end
