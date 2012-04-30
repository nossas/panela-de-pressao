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


Given /^there is an unmoderated campaign called "([^"]*)"$/ do |arg1|
  Campaign.make! name: arg1, accepted_at: nil 
end

Given /^I fill "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

Given /^I'm logged in$/ do
  visit "/auth/facebook"
end

Given /^I attach an image to "([^"]*)"$/ do |arg1|
  attach_file arg1, File.dirname(__FILE__) + "/../support/campaign.png"
end

Given /^I select "([^"]*)" for "([^"]*)"$/ do |arg1, arg2|
  select arg1, :from => arg2
end

Given /^there is a target with email for this campaign$/ do
  Target.make! :campaign => @campaign
end

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

When /^I go to the ([^"]*)$/ do |arg1|
  step "I'm in the #{arg1}"
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button arg1
end

When /^I click "([^"]*)"$/ do |arg1|
  click_link arg1
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |arg1, arg2|
  page.html.should match(/#{arg1}(.|\s)+#{arg2}/)
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Then /^I should be in the ([^"]*)$/ do |arg1|
  case arg1
  when "campaigns page"
    page.current_path.should be_== campaigns_path
  when "login page"
    page.current_path.should be_== new_session_path
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
  ActionMailer::Base.deliveries.should_not be_empty
end
