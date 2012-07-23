class AddMapEmbedAndMapDescriptionToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :map_embed, :string, default: nil
    add_column :campaigns, :map_description, :text, default: nil
  end
end
