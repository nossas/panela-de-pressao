class AddCnpjToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :cnpj, :string, null: false
  end
end
