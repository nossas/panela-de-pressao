class CreateOrganizationMembers < ActiveRecord::Migration
  def change
    create_table :organization_members do |t|
      t.integer :organization_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end
end
