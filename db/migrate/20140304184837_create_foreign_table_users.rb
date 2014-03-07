class CreateForeignTableUsers < ActiveRecord::Migration
  def up
    if Rails.env.production? || Rails.env.staging?
      execute ""\
        "CREATE FOREIGN TABLE users(id integer NOT NULL, email character varying(255) DEFAULT ''::character varying NOT NULL, first_name character varying(255) NOT NULL, last_name character varying(255) NOT NULL, avatar character varying(255), skills character varying(255)[] DEFAULT '{}'::character varying[]) "\
        "SERVER meurio_accounts "\
        "OPTIONS (table_name 'users');"
    else
      create_table :users do |t|
        t.string :email
        t.string :first_name
        t.string :last_name
        t.string :avatar
        t.string :skills, array: true, default: '{}'
        t.timestamps
      end
    end
  end

  def down
    if Rails.env.production? || Rails.env.staging?
      execute "DROP FOREIGN TABLE users;"
    else
      execute "DROP TABLE users;"
    end
  end
end
