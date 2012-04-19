class AddForeignKeyToCampaigns < ActiveRecord::Migration
  def change
    add_foreign_key :campaigns, :organizations
    add_foreign_key :campaigns, :users
  end
end
