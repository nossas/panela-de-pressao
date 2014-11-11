class CreateInfluencersInfluencersGroups < ActiveRecord::Migration
  def change
    create_table :influencers_influencers_groups do |t|
      t.integer :influencer_id
      t.integer :influencers_group_id
    end
  end
end
