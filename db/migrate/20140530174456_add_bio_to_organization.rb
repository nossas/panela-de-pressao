class AddBioToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :bio, :text
  end
end
