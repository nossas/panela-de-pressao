class CreateInfluencers < ActiveRecord::Migration
  def change
    create_table :influencers do |t|
      t.string :name, :null => false
      t.string :email
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
