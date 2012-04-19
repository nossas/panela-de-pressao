Given /^I'm in the campaigns page$/ do
  visit campaigns_path
end

Given /^there is a campaign called "([^"]*)"$/ do |arg1|
  Campaign.make! name: arg1
end

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

When /^I go to the campaigns page$/ do
  visit campaigns_path
end
