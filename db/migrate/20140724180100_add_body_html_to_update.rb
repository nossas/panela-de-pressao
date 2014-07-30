class AddBodyHtmlToUpdate < ActiveRecord::Migration
  def change
    add_column :updates, :body_html, :text
  end
end
