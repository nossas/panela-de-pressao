class AddConstraintsToPokes < ActiveRecord::Migration
  def change
    add_index :pokes, [:user_id, :campaign_id]
    add_index :pokes, :user_id
    add_index :pokes, :campaign_id
    add_index :pokes, :kind
  end
end
