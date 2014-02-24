class DropFacebookPostUidFromUpdate < ActiveRecord::Migration
  def up
    remove_column :updates, :facebook_post_uid
  end

  def down
    add_column :updates, :facebook_post_uid, :string
  end
end
