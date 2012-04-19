class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.text :name, :null => false

      t.timestamps
    end
  end
end
