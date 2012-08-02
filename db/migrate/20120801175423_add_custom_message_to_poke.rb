class AddCustomMessageToPoke < ActiveRecord::Migration
  def change
    add_column :pokes, :custom_message, :text
  end
end
