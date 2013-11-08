class DropUserFks < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE authorizations DROP CONSTRAINT IF EXISTS fk_authorizations_user_id;
    SQL
  end

  def down
  end
end
