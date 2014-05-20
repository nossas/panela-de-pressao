class AddStateAndCountryToUser < ActiveRecord::Migration
  def change
    add_column :users, :state, :string
    add_column :users, :country, :string
  end
end
