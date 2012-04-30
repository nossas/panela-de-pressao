class CreatePokes < ActiveRecord::Migration
  def change
    create_table :pokes do |t|
      t.integer :user_id, :null => false
      t.integer :campaign_id, :null => false
      t.string :kind, :null => false

      t.timestamps
    end
  end
end
