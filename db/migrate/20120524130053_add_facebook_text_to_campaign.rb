class AddFacebookTextToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :facebook_text, :text
  end
end
