class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.integer :influencer_id, :null => false
      t.integer :campaign_id, :null => false

      t.timestamps
    end

    add_index :targets, [:influencer_id, :campaign_id], {:unique => true}
  end
end
