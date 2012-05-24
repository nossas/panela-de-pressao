class AddEmailTextToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :email_text, :text
  end
end
