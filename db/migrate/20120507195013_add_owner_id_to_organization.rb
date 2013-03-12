class AddOwnerIdToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :owner_id, :integer, null: false, foreign_key: { references: :users }
  end
end
