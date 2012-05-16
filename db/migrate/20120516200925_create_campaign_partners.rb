class CreateCampaignPartners < ActiveRecord::Migration
  def change
    create_table :campaign_partners do |t|
      t.integer :campaign_id
      t.integer :user_id
      t.integer :organization_id
      t.timestamps
    end
  end
end
