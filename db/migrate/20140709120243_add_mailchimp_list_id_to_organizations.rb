class AddMailchimpListIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :mailchimp_list_id, :string, foreign_key: false
  end
end
