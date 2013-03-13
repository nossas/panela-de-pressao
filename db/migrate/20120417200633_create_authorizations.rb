class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.text :provider
      t.text :uid

      t.timestamps
    end
  end
end
