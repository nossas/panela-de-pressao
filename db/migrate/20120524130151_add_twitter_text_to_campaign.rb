class AddTwitterTextToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :twitter_text, :text
  end
end
