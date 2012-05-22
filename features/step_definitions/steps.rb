# coding: utf-8
Given /^I'm in ([^"]*)$/ do |arg1|
  case arg1
  when "the campaigns page"
    visit campaigns_path
  when "the new campaign page"
    visit new_campaign_path
  when "the influencers page"
    visit influencers_path
  when "this campaign page"
    visit campaign_path(@campaign)
  when "this campaign editing page"
    visit edit_campaign_path(@campaign)
  else
    raise "I don't know #{arg1}"
  end
end

Given /^there is a campaign called "([^"]*)" accepted on "([^"]*)"$/ do |arg1, arg2|
  @campaign = Campaign.make! name: arg1, accepted_at: Date.parse(arg2)
end

Given /^there is a campaign called "([^"]*)"$/ do |arg1|
  @campaign = Campaign.make! name: arg1, accepted_at: Time.now
end

Given /^there is a campaign called "([^"]*)" awaiting moderation$/ do |arg1|
  @campaign = Campaign.make! name: arg1, accepted_at: nil
end

Given /^I own a campaign called "([^"]*)" awaiting moderation$/ do |arg1|
  @campaign = Campaign.make! name: arg1, accepted_at: nil, :user => Authorization.find_by_uid("536687842").user
end

Given /^I own a campaign called "([^"]*)"$/ do |arg1|
  @campaign = Campaign.make! name: arg1, :user => Authorization.find_by_uid("536687842").user, :accepted_at => Time.now
end

Given /^I fill "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

Given /^I'm logged in$/ do
  visit "/auth/facebook"
end

Given /^I'm logged in with Meu Rio$/ do
  visit "/auth/meurio"
end

Given /^I've created an organization called "([^"]*)"$/ do |arg1|
  Organization.make! name: arg1.to_s, owner: Authorization.find_by_uid("536687842").user, accepted: true
end

Given /^I'm logged in as admin$/ do
  visit "/auth/facebook"
  Authorization.find_by_uid("536687842").user.update_attributes :admin => true
end

Given /^I attach an image to "([^"]*)"$/ do |arg1|
  if arg1 == "Imagem da campanha"
    attach_file arg1, File.dirname(__FILE__) + "/../support/campaign.png"
  elsif arg1 == "Avatar"
    attach_file arg1, File.dirname(__FILE__) + "/../support/influencer.jpg"
  end
end

Given /^I select "([^"]*)" for "([^"]*)"$/ do |arg1, arg2|
  select arg1, :from => arg2
end

Given /^there is a target for this campaign$/ do
  @target = Target.make! :campaign => @campaign
end

Given /^I have a Twitter authorization$/ do
  Authorization.make! :user => Authorization.find_by_uid("536687842").user, :provider => "twitter"
end

Given /^there is a target for this campaign without ([^"]*)$/ do |arg1|
  @target = Target.make! :campaign => @campaign, :influencer => Influencer.make!(:facebook => "") if arg1 == "Facebook"
  @target = Target.make! :campaign => @campaign, :influencer => Influencer.make!(:twitter => "") if arg1 == "Twitter"
end

Given /^there is a poker called "(.*?)"$/ do |arg1|
  @poke = Poke.make! :campaign => @campaign
end

Then /^I should see "([^"]*)"$/ do |arg1|
  if arg1 == "the poker avatar"
    page.should have_css("img[src='/assets/pic.png']")
  else
    page.should have_content(arg1)
  end
end

When /^I go to ([^"]*)$/ do |arg1|
  step "I'm in #{arg1}"
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button arg1
end

When /^I click "([^"]*)"$/ do |arg1|
  if arg1 == "Pressionar via email"
    page.execute_script("$('form:has(input[value=\"email\"])').submit();")
  elsif arg1 == "Pressionar via Facebook"
    page.execute_script("$('form:has(input[value=\"facebook\"])').submit();")
  elsif arg1 == "Pressionar via Twitter"
    page.execute_script("$('form:has(input[value=\"twitter\"])').submit();")
  else
    click_link arg1
  end
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |arg1, arg2|
  page.html.should match(/#{arg1}(.|\s)+#{arg2}/)
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  if arg1 == "the Twitter poke button"
    page.should_not have_button("Via Twitter")
  elsif arg1 == "the accept campaign button"
    page.should_not have_button("Aceitar campanha")
  elsif arg1 == "the create campaign button"
    page.should_not have_button("Enviar campanha para moderação")
  elsif arg1 == "the edit campaign button"
    page.should_not have_link("Editar campanha")
  elsif arg1 == "the email poke form"
    page.should_not have_css("form:has(input[value='email'])")
  elsif arg1 == "the Facebook poke button"
    page.should_not have_css("form:has(input[value='facebook'])")
  else
    page.should_not have_content(arg1)
  end
end

Then /^I should be in ([^"]*)$/ do |arg1|
  case arg1
  when "the campaigns page"
    page.current_path.should be_== campaigns_path
  when "the login page"
    page.current_path.should be_== new_session_path
  when "this campaign page"
    page.current_path.should be_== campaign_path(@campaign)
  else
    raise "I don't know '#{arg1}'"
  end
end

Then /^I should see the campaigns' ([^"]*)$/ do |arg|
  case arg
  when "name"
    page.should have_content(@campaign.name)
  when "description"
    page.should have_content(@campaign.description)
  when "image"
    page.should have_xpath("//img[@src='#{@campaign.image.url}']")
  end  
end

Then /^an email should be sent$/ do
  sleep(1)
  ActionMailer::Base.deliveries.should_not be_empty
end

Then /^no email should be sent$/ do
  ActionMailer::Base.deliveries.should be_empty
end

Then /^a ([^"]*) poke should be added to the target$/ do |arg1|
  @target.reload.pokes_by_email.should be_== 1 if arg1 == "email"
  @target.reload.pokes_by_facebook.should be_== 1 if arg1 == "facebook"
end

Then /^this campaign should be accepted$/ do
  @campaign.reload.should be_accepted
end
