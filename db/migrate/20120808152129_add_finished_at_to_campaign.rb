class AddFinishedAtToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :finished_at, :datetime
  end
end
