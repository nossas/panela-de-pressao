class AddSecretToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :secret, :text
  end
end
