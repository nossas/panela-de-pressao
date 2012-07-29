class AddPokersEmailToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :pokers_email, :text
  end
end
