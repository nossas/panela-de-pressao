class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :profession, :string
  end
end
