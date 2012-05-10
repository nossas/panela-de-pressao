class AddAddressToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :address, :string, null: false
  end
end
