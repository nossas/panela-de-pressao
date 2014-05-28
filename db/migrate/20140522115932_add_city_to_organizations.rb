class AddCityToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :city, :string
  end
end
