class AddAvatarToInfluencer < ActiveRecord::Migration
  def change
    add_column :influencers, :avatar, :string
  end
end
