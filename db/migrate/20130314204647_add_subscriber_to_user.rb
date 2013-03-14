class AddSubscriberToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscriber, :boolean, :default => true
  end
end
