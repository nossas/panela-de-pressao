Given /^I'm in the campaigns page$/ do
  visit campaigns_path
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

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

When /^I go to the campaigns page$/ do
  visit campaigns_path
end


Then /^I should see "([^"]*)" before "([^"]*)"$/ do |arg1, arg2|
  page.html.should match(/#{arg1}(.|\s)+#{arg2}/)
end


Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should_not have_content(arg1)
end
