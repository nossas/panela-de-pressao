class AlterTableCampaignsUsersRenameToCampaignOwners < ActiveRecord::Migration
  def up
    execute "ALTER TABLE campaigns_users RENAME TO campaign_owners"
  end

  def down
    execute "ALTER TABLE campaign_owners RENAME TO campaigns_users"
  end
end
