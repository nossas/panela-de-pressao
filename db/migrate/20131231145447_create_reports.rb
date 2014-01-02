class CreateReports < ActiveRecord::Migration
  def change
    SchemaPlus.config.foreign_keys.auto_create = false
    SchemaPlus.config.foreign_keys.auto_index = false

    create_table :reports do |t|
      t.integer :campaign_id
      t.integer :user_id

      t.timestamps
    end
  end
end
