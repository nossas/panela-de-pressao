class AddPokesByEmailToTarget < ActiveRecord::Migration
  def change
    add_column :targets, :pokes_by_email, :integer, :default => 0
  end
end
