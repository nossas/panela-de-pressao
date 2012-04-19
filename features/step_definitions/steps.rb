Given /^I'm in the campaigns page$/ do
  visit campaigns_path
end

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end
