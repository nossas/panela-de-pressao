class InstallSomeContribPackages < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS pg_trgm;
      CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
      CREATE EXTENSION IF NOT EXISTS unaccent;
    SQL
  end

  def down
    execute <<-SQL
      DROP EXTENSION IF EXISTS pg_trgm;
      DROP EXTENSION IF EXISTS fuzzystrmatch;
      DROP EXTENSION IF EXISTS unaccent;
    SQL
  end
end
