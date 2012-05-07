class AddPokesByTwitterToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :pokes_by_twitter, :integer, :null => false, :default => 0 
  end
end
