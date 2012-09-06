class AddSucceedToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :succeed, :boolean
  end
end
