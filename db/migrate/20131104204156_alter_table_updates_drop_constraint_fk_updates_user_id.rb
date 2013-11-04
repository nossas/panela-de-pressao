class AlterTableUpdatesDropConstraintFkUpdatesUserId < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE updates DROP CONSTRAINT fk_updates_user_id;
    SQL
  end

  def down
  end
end
