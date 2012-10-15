class AddDescriptionHtmlToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :description_html, :text, default: nil
  end
end
