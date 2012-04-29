class AddRoleToInfluencer < ActiveRecord::Migration
  def change
    add_column :influencers, :role, :string, :null => false
  end
end
