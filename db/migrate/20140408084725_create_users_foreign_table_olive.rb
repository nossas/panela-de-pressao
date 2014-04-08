class CreateUsersForeignTableOlive < ActiveRecord::Migration
  def up
    if Rails.env.production? || Rails.env.staging?
      execute(
      %Q{
        CREATE FOREIGN TABLE users(
          id integer NOT NULL,
          email character varying(255) DEFAULT ''::character varying NOT NULL,
          first_name character varying(255) NOT NULL,
          last_name character varying(255) NOT NULL,
          avatar character varying(255),
          skills character varying(255)[] DEFAULT '{}'::character varying[],
          admin boolean,
          phone character varying(255),
          bio text,
          profession character varying(255)
        )
        SERVER meurio_accounts
        OPTIONS (table_name 'users');
      }
      )
    end
  end

  def down
    if Rails.env.production? || Rails.env.staging?
      execute 'DROP FOREIGN TABLE users;'
    end
  end
end
