class CreateRecomendations < ActiveRecord::Migration
  def up
    create_view :recomendations, "SELECT DISTINCT r.id AS campaign_id, p.user_id AS user_id, s.id AS source_id FROM campaigns s JOIN pokes p ON p.campaign_id = s.id JOIN campaigns r USING(category_id) WHERE NOT EXISTS (SELECT true FROM pokes p2 WHERE p2.campaign_id = r.id AND p2.user_id = p.user_id) AND r.accepted_at IS NOT NULL AND r.archived_at IS NULL AND r.finished_at IS NULL;"
  end

  def down
    drop_view :recomendations
  end
end
