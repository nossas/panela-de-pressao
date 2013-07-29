class AddArchivedToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :archived_at, :datetime
    add_index :influencers, :archived_at
  end
end
