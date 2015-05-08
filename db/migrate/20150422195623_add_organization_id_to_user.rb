class AddOrganizationIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :organization_id, :integer, foreign_key: false
  end
end
