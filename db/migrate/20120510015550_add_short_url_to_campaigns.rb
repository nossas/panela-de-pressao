class AddShortUrlToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :short_url, :text
  end
end
