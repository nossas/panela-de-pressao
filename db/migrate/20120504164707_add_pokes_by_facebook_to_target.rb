class AddPokesByFacebookToTarget < ActiveRecord::Migration
  def change
    add_column :targets, :pokes_by_facebook, :integer, :default => 0
  end
end
