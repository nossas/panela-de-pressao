class RemoveMailchimpListIdFromOrganizations < ActiveRecord::Migration
  def change
    if Organization.column_names.include?('mailchimp_list_id')
      remove_column :organizations, :mailchimp_list_id, :integer
    end
  end
end
