class AddLinkToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :link, :string
  end
end
