class AddCategoryIdToCampaign < ActiveRecord::Migration
  def change
    execute "TRUNCATE campaigns CASCADE"
    add_column :campaigns, :category_id, :integer, :null => false
  end
end
