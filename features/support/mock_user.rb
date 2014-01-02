Before do
  ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS users;")
  ActiveRecord::Base.connection.execute("
    CREATE TABLE IF NOT EXISTS users(
      id          SERIAL PRIMARY KEY, 
      email       varchar(40) NOT NULL, 
      first_name  varchar(40) NOT NULL, 
      last_name   varchar(40) NOT NULL,
      admin       boolean,
      profession  character varying(255),      
      avatar      varchar(40),
      phone       varchar(40)
    );
  ")

  User.any_instance.stub(:avatar_url).and_return("/assets/default-avatar.png")
end
