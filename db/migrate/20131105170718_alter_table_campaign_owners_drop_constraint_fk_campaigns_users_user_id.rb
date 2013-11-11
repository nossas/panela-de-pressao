class AlterTableCampaignOwnersDropConstraintFkCampaignsUsersUserId < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE campaign_owners DROP CONSTRAINT IF EXISTS fk_campaigns_users_user_id;
    SQL
  end

  def down
  end
end
