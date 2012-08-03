class AddFacebookUrlToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :facebook_url, :string
  end
end
