class AddFacebookIdToInfluencer < ActiveRecord::Migration
  def change
    add_column :influencers, :facebook_id, :string, :foreign_key => false
  end
end
