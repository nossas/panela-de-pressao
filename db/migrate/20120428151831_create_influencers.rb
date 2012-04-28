class CreateInfluencers < ActiveRecord::Migration
  def change
    create_table :influencers do |t|
      t.string :name, :null => false
      t.string :email
      t.string :twitter
      t.string :facebook

      t.timestamps
    end

    add_index :influencers, :email, {:unique => true}
    add_index :influencers, :twitter, {:unique => true}
    add_index :influencers, :facebook, {:unique => true}
  end
end
