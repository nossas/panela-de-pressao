class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name, :null => false
      t.text :email, :null => false
      t.text :picture

      t.timestamps
    end
  end
end
