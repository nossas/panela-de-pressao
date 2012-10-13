class AddVideoUrlToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :video_url, :string
  end
end
