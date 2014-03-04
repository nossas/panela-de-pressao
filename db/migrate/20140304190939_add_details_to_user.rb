class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :birthdate, :date
    add_column :users, :profession, :string
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :secondary_email, :string
    add_column :users, :public, :boolean
  end
end
