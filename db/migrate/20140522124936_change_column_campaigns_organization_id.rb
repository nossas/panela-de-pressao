class ChangeColumnCampaignsOrganizationId < ActiveRecord::Migration
  def up
    change_column :campaigns, :organization_id, :integer, null: false, foreign_key: false
  end

  def down
    change_column :campaigns, :organization_id, :integer
  end
end
