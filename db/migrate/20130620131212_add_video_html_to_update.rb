class AddVideoHtmlToUpdate < ActiveRecord::Migration
  def change
    add_column :updates, :video_html, :string
  end
end
