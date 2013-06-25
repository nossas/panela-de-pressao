def route_to_path route
  return campaigns_path                    if route == "the campaigns page"
  return campaign_path(@campaign)          if route == "this campaign page"
  return new_campaign_path                 if route == "the new campaign page"
  return answers_campaign_path(@campaign)  if route == "the answers page of the campaign"
  return unmoderated_campaigns_path        if route == "the unmoderated campaigns page"
  return root_path                         if route == "the homepage"
  return '/auth/facebook/callback'         if route == "the Facebook callback"
  return updates_campaign_path(@campaign)  if route == "the updates page of the campaign"
  raise "I don't know '#{route}'"
end
