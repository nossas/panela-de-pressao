class DropTableUsers < ActiveRecord::Migration
  def up
    execute "DROP TABLE users CASCADE CONSTRAINTS PURGE"
  end

  def down
    create_table "users", :force => true do |t|
      t.text     "name",                            :null => false
      t.text     "email",                           :null => false
      t.text     "picture"
      t.datetime "created_at",                      :null => false
      t.datetime "updated_at",                      :null => false
      t.boolean  "admin",        :default => false
      t.text     "about_me"
      t.string   "file"
      t.string   "mobile_phone"
      t.boolean  "subscriber",   :default => true
      t.string   "token"
    end
  end
end
