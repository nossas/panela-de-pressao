class CreateInfluencersGroups < ActiveRecord::Migration
  def change
    create_table :influencers_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
