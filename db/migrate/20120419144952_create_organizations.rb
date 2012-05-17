class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.text :name, :null => false
      t.text :cnpj, :null => false
      t.text :address, :null => false
      t.timestamps
    end
  end
end
