class AlterTablePokesDropConstraingFkPokesUserId < ActiveRecord::Migration
  def up
    execute <<-SQL
        ALTER TABLE pokes DROP CONSTRAINT fk_pokes_user_id;
    SQL
  end

  def down
  end
end
