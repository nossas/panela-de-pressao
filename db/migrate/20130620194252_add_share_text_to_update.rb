class AddShareTextToUpdate < ActiveRecord::Migration
  def change
    add_column :updates, :share_text, :text
  end
end
