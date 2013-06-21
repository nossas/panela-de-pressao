class AddFacebookPostIdToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :facebook_post_uid, :string
  end
end
