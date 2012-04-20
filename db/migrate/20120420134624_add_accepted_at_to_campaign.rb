class AddAcceptedAtToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :accepted_at, :datetime
  end
end
