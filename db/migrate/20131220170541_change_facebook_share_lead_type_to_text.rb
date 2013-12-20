class ChangeFacebookShareLeadTypeToText < ActiveRecord::Migration
  def up
    change_table :campaigns do |t|
      t.change :facebook_share_lead, :text
    end
  end
 
  def down
    change_table :campaigns do |t|
      t.change :facebook_share_lead, :string
    end
  end
end
