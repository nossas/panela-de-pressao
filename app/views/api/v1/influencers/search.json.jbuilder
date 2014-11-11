json.array! @documents do |document|
  json.searchable_type document.searchable_type
  json.searchable_id document.searchable_id

  if document.searchable_type == "Influencer"
    json.content "#{document.searchable.name}, #{document.searchable.role}"
  elsif document.searchable_type == "InfluencersGroup"
    json.content document.searchable.name
  end

  json.searchable do
    json.id document.searchable.id
    json.name document.searchable.name

    if document.searchable_type == "Influencer"
      json.role document.searchable.role
      json.html render(partial: 'influencers/influencer_field.html', locals: { influencer: document.searchable })
    elsif document.searchable_type == "InfluencersGroup"
      json.html render(partial: 'influencers/influencer_field.html', collection: document.searchable.influencers, as: :influencer)
    end
  end
end
