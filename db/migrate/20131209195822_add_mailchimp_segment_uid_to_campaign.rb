class AddMailchimpSegmentUidToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :mailchimp_segment_uid, :integer
  end
end
