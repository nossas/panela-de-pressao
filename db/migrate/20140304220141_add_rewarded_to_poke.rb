class AddRewardedToPoke < ActiveRecord::Migration
  def change
    add_column :pokes, :rewarded, :boolean, default: false
  end
end
