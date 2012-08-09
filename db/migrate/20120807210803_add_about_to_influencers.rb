class AddAboutToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :about, :text
  end
end
