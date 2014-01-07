class RemovePreviewCodeFromCampaign < ActiveRecord::Migration
  def up
    remove_column :campaigns, :preview_code
  end

  def down
    add_column :campaigns, :preview_code, :string
  end
end
