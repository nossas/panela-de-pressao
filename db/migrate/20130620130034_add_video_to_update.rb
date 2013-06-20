class AddVideoToUpdate < ActiveRecord::Migration
  def change
    add_column :updates, :video, :string
  end
end
