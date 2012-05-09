class AddTokenToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :token, :text
  end
end
