class RemoveCnpjAndAddressFromOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :cnpj
    remove_column :organizations, :address
  end
end
