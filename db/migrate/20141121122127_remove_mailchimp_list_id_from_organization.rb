class RemoveMailchimpListIdFromOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :mailchimp_list_id, :string
  end
end
