class AddForeignKeyToIssues < ActiveRecord::Migration
  def change
    add_foreign_key :issues, :organizations
    add_foreign_key :issues, :users
  end
end
