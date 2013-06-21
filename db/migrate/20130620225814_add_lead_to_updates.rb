class AddLeadToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :lead, :text
  end
end
