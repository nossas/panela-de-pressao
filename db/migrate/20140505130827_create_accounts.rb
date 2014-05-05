class CreateAccounts < ActiveRecord::Migration
  def up
    if Rails.env.production? || Rails.env.staging?
      execute ""\
      "CREATE FOREIGN TABLE users(id integer NOT NULL) "\
      "SERVER meurio_accounts "\
      "OPTIONS (table_name 'accounts');"
    else
      create_table :accounts do |t|
        t.timestamps
      end
    end
  end

  def down
    if Rails.env.production? || Rails.env.staging?
      execute "DROP FOREIGN TABLE users"
    else
      drop_table :accounts
    end
  end
end
