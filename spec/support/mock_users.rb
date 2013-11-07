RSpec.configure do |config|
  config.before do
    ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS users;")
    ActiveRecord::Base.connection.execute("
      CREATE TABLE IF NOT EXISTS users(
        id          SERIAL PRIMARY KEY, 
        email       varchar(40), 
        first_name  varchar(40), 
        last_name   varchar(40),
        admin       boolean,
        avatar      varchar(40),
        phone       varchar(40)
      );
    ")
    User.any_instance.stub(:avatar_url).and_return("/assets/default-avatar.png")
  end
end
