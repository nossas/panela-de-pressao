class DropTablePosts < ActiveRecord::Migration
  def up
    drop_table :posts
  end

  def down
    create_table :posts do |t|
      t.integer :campaign_id, :null => false
      t.text :content, :null => false
      t.text :content_html, :null => false

      t.timestamps
    end

    add_foreign_key :posts, :campaigns
  end
end
