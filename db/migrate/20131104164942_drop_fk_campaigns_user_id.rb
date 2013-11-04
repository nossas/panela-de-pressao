class DropFkCampaignsUserId < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE campaigns DROP CONSTRAINT fk_campaigns_user_id;
    SQL
  end

  def down
  end
end
