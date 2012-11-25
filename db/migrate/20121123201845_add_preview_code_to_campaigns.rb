class AddPreviewCodeToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :preview_code, :string
  end
end
