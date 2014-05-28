class CreateAccountsOrganizations < ActiveRecord::Migration
  def up
    if Rails.env.production? || Rails.env.staging?
      execute <<-SQL
        CREATE FOREIGN TABLE organizations(id integer)
        SERVER meurio_accounts
        OPTIONS (table_name 'organizations');
      SQL
    else
      create_table :organizations
    end
  end

  def down
    if Rails.env.production? || Rails.env.staging?
      execute "DROP FOREIGN TABLE organizations;"
    else
      drop_table :organizations
    end
  end
end
