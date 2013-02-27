class AddModeratorIdToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :moderator_id, :integer
  end
end
