class DropShareTextFromUpdate < ActiveRecord::Migration
  def up
    remove_column :updates, :share_text
  end
  
  def down
    add_column :updates, :share_text, :text
  end
end
