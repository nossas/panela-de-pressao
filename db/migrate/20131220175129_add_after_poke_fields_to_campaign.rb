class AddAfterPokeFieldsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :after_poke_title, :string
    add_column :campaigns, :after_poke_text, :text
    add_column :campaigns, :after_poke_link, :string
    add_column :campaigns, :after_poke_call_to_action, :string
  end
end
