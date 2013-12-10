class AddPokeTypeToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :poke_type, :string, default: 'email'
  end
end
