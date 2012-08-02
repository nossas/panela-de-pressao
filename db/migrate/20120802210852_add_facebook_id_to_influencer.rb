class AddFacebookIdToInfluencer < ActiveRecord::Migration
  def change
    add_column :influencers, :facebook_id, :string
  end
end
