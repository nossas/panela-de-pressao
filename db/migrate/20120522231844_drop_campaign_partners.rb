class DropCampaignPartners < ActiveRecord::Migration
  def up
    drop_table :campaign_partners
  end

  def down
    create_table :campaign_partners do |t|
      t.integer :campaign_id
      t.integer :user_id
      t.integer :organization_id
      t.timestamps
    end
  end
end
