class FixMapEmbedOnCampaigns < ActiveRecord::Migration
  def change
    change_column :campaigns, :map_embed, :text, default: nil
  end
end
