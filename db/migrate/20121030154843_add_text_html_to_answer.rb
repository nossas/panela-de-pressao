class AddTextHtmlToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :text_html, :text
  end
end
