class AddAccountsOrganizationIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :organization_id, :integer, foreign_key: false
  end
end
