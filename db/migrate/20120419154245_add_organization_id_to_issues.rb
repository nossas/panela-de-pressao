class AddOrganizationIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :organization_id, :integer
  end
end
