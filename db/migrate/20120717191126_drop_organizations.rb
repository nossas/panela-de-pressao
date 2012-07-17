class DropOrganizations < ActiveRecord::Migration
  def up
    drop_table :organization_members
    drop_table :campaigns_organizations
    remove_column :campaigns, :organization_id
    drop_table :organizations
  end

  def down
    create_table :organizations do |t|
      t.text     "name",                          :null => false
      t.integer  "owner_id",                      :null => false
      t.boolean  "accepted",   :default => false, :null => false
      t.string   "avatar",                        :null => false
      t.string   "link"
      t.timestamps
    end
    
    add_column :campaigns, :organization_id, :integer

    create_table "campaigns_organizations" do |t|
      t.integer "campaign_id",     :null => false
      t.integer "organization_id", :null => false
    end

    create_table "organization_members" do |t|
      t.integer  "organization_id", :null => false
      t.integer  "user_id",         :null => false
      t.timestamps
    end
  end
end
