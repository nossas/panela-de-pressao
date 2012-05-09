class AddAcceptedToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :accepted, :boolean, default: false, null: false
  end
end
