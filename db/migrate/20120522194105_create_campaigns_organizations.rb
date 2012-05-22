class CreateCampaignsOrganizations < ActiveRecord::Migration
  def change
    create_table :campaigns_organizations do |t|
      t.integer :campaign_id, :null => false
      t.integer :organization_id, :null => false
    end
  end
end
