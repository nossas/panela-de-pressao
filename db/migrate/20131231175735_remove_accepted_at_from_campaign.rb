class RemoveAcceptedAtFromCampaign < ActiveRecord::Migration
  def up
    remove_column :campaigns, :accepted_at
  end

  def down
    add_column :campaigns, :accepted_at, :datetime
  end
end
