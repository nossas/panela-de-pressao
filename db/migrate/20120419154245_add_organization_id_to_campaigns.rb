class AddOrganizationIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :organization_id, :integer
  end
end
