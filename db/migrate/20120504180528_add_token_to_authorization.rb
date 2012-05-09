class AddTokenToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :token, :string
  end
end
