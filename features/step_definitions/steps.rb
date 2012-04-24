Given /^I'm in the ([^"]*)$/ do |page|
  case page
  when "campaigns page"
    visit campaigns_path
  when "new campaign page"
    visit new_campaign_path
  end
end

Given /^there is a campaign called "([^"]*)" accepted on "([^"]*)"$/ do |arg1, arg2|
  Campaign.make! name: arg1, accepted_at: Date.parse(arg2)
end


Given /^there is a campaign called "([^"]*)"$/ do |arg1|
  Campaign.make! name: arg1, accepted_at: Time.now
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

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

When /^I go to the campaigns page$/ do
  visit campaigns_path
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button arg1
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |arg1, arg2|
  page.html.should match(/#{arg1}(.|\s)+#{arg2}/)
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Then /^I should be in the campaigns page$/ do
  page.current_path.should be_== campaigns_path
end
