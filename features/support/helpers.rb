def route_to_path route
  return campaigns_path                                                   if route == "the campaigns page"
  return campaign_path(@campaign)                                         if route == "this campaign page"
  return new_campaign_path                                                if route == "the new campaign page"
  return answers_campaign_path(@campaign)                                 if route == "the answers page of the campaign"
  return unmoderated_campaigns_path                                       if route == "the unmoderated campaigns page"
  return root_path                                                        if route == "the homepage"
  return '/auth/facebook/callback'                                        if route == "the Facebook callback"
  return updates_campaign_path(@campaign)                                 if route == "the updates page of the campaign"
  return edit_campaign_path(@campaign)                                    if route == "this campaign editing page"
  return new_influencer_path                                              if route == "the new influencer page"
  return user_unsubscribe_path(@user)                                     if route == "this user unsubscribe page"
  return influencer_path(@target.influencer)                              if route == "this target page"
  return updates_campaign_path(@campaign, anchor: "update_#{@update.id}") if route == "this update page"
  raise "I don't know '#{route}'"
end

def to_element string
  return ".campaign"                                  if string == "the campaign list"
  return I18n.l(@campaign.created_at, format: :short) if string == "the submition date"
  return @campaign.user.email                         if string == "the cooker's email"
  raise "I don't know '#{string}'"
end
