class AddFacebookFieldsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :facebook_share_title, :string
    add_column :campaigns, :facebook_share_lead, :string
    add_column :campaigns, :facebook_share_thumb, :string
  end
end
