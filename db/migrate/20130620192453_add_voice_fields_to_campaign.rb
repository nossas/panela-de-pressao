class AddVoiceFieldsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :voice_call_script, :text, default: nil 
    add_column :campaigns, :voice_call_number, :string, default: nil
  end
end
