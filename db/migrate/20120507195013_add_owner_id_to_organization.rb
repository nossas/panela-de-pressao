class AddOwnerIdToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :owner_id, :integer, null: false
  end

  add_foreign_key :organizations, :users, column: 'owner_id'
end
