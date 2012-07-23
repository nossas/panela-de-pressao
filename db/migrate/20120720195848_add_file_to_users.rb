class AddFileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :file, :string, default: nil
  end
end
