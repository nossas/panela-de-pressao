class AlterTableCampaignsDropConstraintFkCampaignsModeratorId < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE campaigns DROP CONSTRAINT IF EXISTS fk_campaigns_moderator_id;
    SQL
  end

  def down
  end
end
