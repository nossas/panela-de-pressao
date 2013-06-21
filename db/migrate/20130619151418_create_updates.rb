class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :campaign_id
      t.string :image
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
