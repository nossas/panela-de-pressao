class AddFeaturedAtToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :featured_at, :datetime, default: nil
  end
end
