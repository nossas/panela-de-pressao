class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.integer :influencer_id, :null => false
      t.integer :campaign_id, :null => false

      t.timestamps
    end

    add_foreign_key :targets, :influencers
    add_foreign_key :targets, :campaigns
    add_index :targets, [:influencer_id, :campaign_id], {:unique => true}
  end
end
