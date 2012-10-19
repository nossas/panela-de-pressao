class CreateCampaignsUsers < ActiveRecord::Migration
  def change
    create_table :campaigns_users do |t|
      t.integer :campaign_id, :null => false
      t.integer :user_id, :null => false
    end
  end
end
