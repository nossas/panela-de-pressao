class RemoveFeaturedFromCampaigns < ActiveRecord::Migration
  def up
    remove_column :campaigns, :featured
  end

  def down
    add_column :campaigns, :featured
  end
end
