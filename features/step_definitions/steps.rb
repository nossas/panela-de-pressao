# coding: utf-8
Given /^I'm in ([^"]*)$/ do |arg1|
  visit route_to_path(arg1)
end

Given /^there is a campaign created by "(.*?)" with no partnership$/ do |arg1|
  @campaign = Campaign.make! :user => User.make!(:name => arg1), :accepted_at => Time.now
end

Given /^there is a campaign created by "(.*?)" with a partnership with "(.*?)"$/ do |arg1, arg2|
  @campaign = Campaign.make! :user => User.make!(:name => arg1), :accepted_at => Time.now, :organizations => [Organization.make!(:name => arg2)]
end

Given /^there is a campaign called "([^"]*)" accepted on "([^"]*)"$/ do |arg1, arg2|
  @campaign = Campaign.make! name: arg1, accepted_at: Date.parse(arg2)
end

Given /^there is a campaign called "(.*?)" with an organization "(.*?)" as supporter accepted on "(.*?)"$/ do |arg1, arg2, arg3|
  @organization = Organization.make! name: arg2
  @campaign = Campaign.make! name: arg1, accepted_at: Date.parse(arg3), organizations: [@organization]
end

Given /^there is (\d+) pokers for this campaign$/ do |arg1|
  @pokes = []
  arg1.to_i.times do 
    @pokes << Poke.make!(campaign: @campaign, user: User.make!)
  end
end

Given /^I should see an avatar from organization "(.*?)"$/ do |arg1|
  page.should have_xpath("//img[@title='#{arg1}']")
end


Given /^there is a campaign called "([^"]*)"$/ do |arg1|
  @campaign = Campaign.make! name: arg1, accepted_at: Time.now
end

Given /^there is a campaign called "([^"]*)" awaiting moderation$/ do |arg1|
  @campaign = Campaign.make! name: arg1, accepted_at: nil
end

Given /^I own a campaign called "([^"]*)" awaiting moderation$/ do |arg1|
  @campaign = Campaign.make! name: arg1, accepted_at: nil, :user => @current_user
end

Given /^I own a campaign called "([^"]*)"$/ do |arg1|
  @campaign = Campaign.make! name: arg1, :user => @current_user, :accepted_at => Time.now
end

Given /^there is 1 poker called "(.*?)" that poked (\d+) times$/ do |name, quant|
  @poker = User.make! name: name 
  quant.to_i.times do
    Poke.make! campaign: @campaign, user: @poker
  end
end

Given /^I fill "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

Given /^I'm logged in$/ do
  @current_user = User.make! email: "ssi@meurio.org.br"
  Authorization.make! user: @current_user
  visit root_path
end

Given /^I've created an organization called "([^"]*)"$/ do |arg1|
  Organization.make! name: arg1.to_s, owner: Authorization.find_by_uid("536687842").user, accepted: true
end

Given /^I'm logged in as admin$/ do
  @current_user = User.make! admin: true, email: "ssi@meurio.org.br"
  Authorization.make! user: @current_user
  visit root_path
end

Given /^I attach an image to "([^"]*)"$/ do |arg1|
  if arg1 == "Para a divulgação da minha campanha bombar, vou usar essa imagem"
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

Given /^there is a target for this campaign called "(.*?)"$/ do |arg1|
  @target = Target.make! campaign: @campaign, influencer: Influencer.make!(name: arg1)
end


Given /^I have a Twitter authorization$/ do
  Authorization.make! :user => @current_user, :provider => "twitter"
end

Given /^there is a target for this campaign without ([^"]*)$/ do |arg1|
  @target = Target.make! :campaign => @campaign, :influencer => Influencer.make!(:facebook_id => "") if arg1 == "Facebook"
  @target = Target.make! :campaign => @campaign, :influencer => Influencer.make!(:twitter => "") if arg1 == "Twitter"
  @target = Target.make! :campaign => @campaign, :influencer => Influencer.make!(:email => "") if arg1 == "E-mail"
end

Given /^there is one target for this campaign without ([^"]*) and without ([^"]*)$/ do |arg1, arg2|
  @target = Target.make! :campaign => @campaign, :influencer => Influencer.make!(:facebook_id => "", twitter: "") if arg1 == "Facebook" and arg2 == "Twitter"
end


Given /^there is a poker called "(.*?)"$/ do |arg1|
  @campaign.targets << Target.make!
  @poke = Poke.make! :campaign => @campaign
end

Given /^I check "(.*?)"$/ do |arg1|
  check(arg1)
end

Given(/^there is (\d+) reported campaigns$/) do |arg1|
  arg1.to_i.times { Report.make! }
end

Then /^I should see "([^"]*)"$/ do |arg1|
  if to_element(arg1)
    page.should have_css(to_element(arg1))
  else
    page.should have_content(arg1)
  end
end

When /^I go to "([^"]*)"$/ do |arg1|
  step "I'm in #{arg1}"
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button to_button(arg1)
end

When /^I click "([^"]*)"$/ do |arg1|
  if arg1 == "Pressionar via email"
    page.execute_script("$('form:has(input[value=\"email\"])').submit();")
  elsif arg1 == "Pressionar via Facebook"
    page.execute_script("$('form:has(input[value=\"facebook\"])').submit();")
  elsif arg1 == "Pressionar via Twitter"
    page.execute_script("$('form:has(input[value=\"twitter\"])').submit();")
  elsif arg1 == "Entrar via Facebook"
    within("#login") do
      click_on arg1
    end
  elsif arg1 == "the report campaign button"
    click_link("report_campaign_button")
  else 
    click_link(arg1)
  end
  if arg1 == "ver/personalizar email" || arg1 == "ver/personalizar mensagem"
    sleep(1)
  end
end

When /^I click on the "(.*?)" avatar$/ do |arg1|
  find(:xpath, "//a[@title=\"#{arg1}\"]").click
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |arg1, arg2|
  page.html.should match(/#{arg1}(.|\s)+#{arg2}/)
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  case arg1
  when "the Twitter poke button"
    page.should_not have_button("Via Twitter")
  when "the accept campaign button"
    page.should_not have_button("Aceitar campanha")
  when "the create campaign button"
    page.should_not have_button("Enviar campanha para moderação")
  when "the edit campaign button"
    page.should_not have_link("Editar campanha")
  when "the email poke form"
    page.should_not have_css(".poke_btn.email")
  when "the Facebook poke button"
    page.should_not have_css(".poke_btn.facebook")
  when "user[email]"
    page.should_not have_css('input[name="user[email]"]')
  when "the answer form"
    page.should_not have_css("form.new_answer")
  when "the pokes buttons"
    page.should_not have_css("form.new_poke")
  when "the new campaign form"
    page.should_not have_css("#new_campaign")
  when "the ownership field"
    page.should_not have_css("select#campaign_user_id", visible: false)
  when "the reported campaigns button"
    page.should_not have_css(to_element("the reported campaigns button"))
  else
    page.should_not have_content(arg1)
  end
end

Then /^I should be in ([^"]*)$/ do |arg1|
  page.current_path.should be_== route_to_path(arg1)
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

Then /^an email called "(.*?)" should be sent$/ do |arg1|
  sleep(1)
  ActionMailer::Base.deliveries.select{|d| d.subject == arg1}.should_not be_empty
end

Then /^no email called "(.*?)" should be sent$/ do |arg1|
  sleep(1)
  ActionMailer::Base.deliveries.select{|d| d.subject == arg1}.should be_empty
end

Then /^an email called "(.*?)" should be sent once$/ do |arg1|
  sleep(1)
  ActionMailer::Base.deliveries.select{|d| d.subject == arg1}.should have(1).email
end

Then /^no email should be sent$/ do
  ActionMailer::Base.deliveries.should be_empty
end

Then /^an? ([^"]*) poke should be added to the target$/ do |arg1|
  @target.reload.pokes_by_email.should be_== 1 if arg1 == "email"
  @target.reload.pokes_by_facebook.should be_== 1 if arg1 == "facebook"
end

Then /^this campaign should be accepted$/ do
  @campaign.reload.should be_accepted
end


Then /^I should see a list of (\d+) recent pokers$/ do |arg1|
  page.should have_css("div.pokers ol li", count: arg1.to_i)
end

Then /^I should see a list with order "(.*?)", "(.*?)", "(.*?)"$/ do |arg1, arg2, arg3|
  page.should have_css("div.more_active_pokers", text: /#{arg1}.*#{arg2}.*#{arg3}/)
end

When /^I open my profile options$/ do
  page.execute_script("$('.current_user_links').show();")
end

Given /^I already poked this campaign$/ do
  Poke.make! :campaign => @campaign, :user => @current_user
end

Given /^I pass over the email poke button$/ do
  page.execute_script("$('.email_text').show();")
end

Given /^I pass over the facebook poke button$/ do
  page.execute_script("$('.facebook_text').show();")
end

When /^I press "(.*?)" at "(.*?)"$/ do |arg1, arg2|
  if arg2 == "the facebook poke message"
    within(".facebook_poke_message") do
      click_button arg1
    end
  elsif arg2 == "the email poke message"
    within(".email_poke_message") do
      click_button arg1
    end
  else
    raise "I don't know what to do with '#{arg2}'"
  end
end

Then /^I should not see "(.*?)" in "(.*?)"$/ do |arg1, arg2|
  if arg2 == "the right sidebar"
    within("aside.right.pressure") do
      should_not have_content(arg1)
    end
  else
    raise "I don't know what to do with '#{arg2}'"
  end
end

Then /^a email saying "(.*?)" should be sent$/ do |arg1|
  sleep(1)
  ActionMailer::Base.deliveries.select{|d| d.body.include? arg1}.should_not be_empty
end

Given /^there is an unmoderated campaign called "([^"]*)"$/ do |arg1|
  @campaign = Campaign.make! :name => arg1, :accepted_at => nil
end

Given /^there is an unmoderated campaign called "(.*?)" moderated by "(.*?)"$/ do |arg1, arg2|
  @campaign = Campaign.make! :name => arg1, :accepted_at => nil, :moderator => User.make!(:first_name => arg2)
end

Given /^there is a user$/ do
  @user = User.make!
end

Given /^this user collaborated with a campaign called "(.*?)"$/ do |arg1|
  @campaign = Campaign.make!(:name => arg1, :accepted_at => Time.now)
  @campaign.users << @user
end

Given /^there is a campaign$/ do
  @campaign = Campaign.make!
end

Given /^there is an accepted campaign$/ do
  @campaign = Campaign.make! accepted_at: Time.now
end

Then /^I should see the unsubscription message$/ do
  page.should have_css(".unsubscription_message")
end

When /^I click in the updates button$/ do
  click_link("campaign_updates")
end

Then /^I should see that there is no update yet$/ do
  page.should have_css(".campaign_updates .no_update_yet")
end

Given /^there is an update for this campaign$/ do
  @update = Update.make!(campaign: @campaign)
end

Then /^I should see the update$/ do
  page.should have_css(".update .title", text: @update.title)
end

Given /^there is an update with an image for this campaign$/ do
  @update = Update.make!(campaign: @campaign)
end

When /^I click in the update title$/ do
  page.find(".update .title a").click
end

Then /^I should see the update popup$/ do
  page.should have_css(".update_facebox")
end

Then /^I should see the update image$/ do
  page.should have_css(".update_facebox .image")
end

Given /^there is an update with a video for this campaign$/ do
  @update = Update.make!(campaign: @campaign, video: "http://www.youtube.com/watch?v=ojErI546Sg8")
end

Then /^I should see the update video$/ do
  page.should have_css(".update_facebox .video")
end

Then /^I should see the successful poke message$/ do
  page.should have_css(".poke_buttons .headline_poked")
end

Then /^I should see the new update button$/ do
  page.should have_css(".campaign_updates a#new_update")
end

Given /^I click in the new update button$/ do
  page.find(".campaign_updates a#new_update").click
end

Given /^I fill the new update form right$/ do
  within "form.new_update" do
    fill_in     "update_title",       with: Faker::Lorem.sentence
    attach_file "update_image",       "#{Rails.root}/features/support/campaign.png"
    fill_in     "update_body",        with: Faker::Lorem.paragraph
    fill_in     "update_lead",        with: Faker::Lorem.paragraph
    fill_in     "update_share_text",  with: Faker::Lorem.paragraph
  end
end

When /^I submit the new update form$/ do
  page.find("form.new_update input[type='submit']").click
end

Then /^I should see the new update in a facebox$/ do
  page.should have_css(".update_facebox")
end

Then /^I should see the new update in the Meu Rio Facebook page$/ do
  Update.order("id DESC").first.facebook_post_uid.should be_== "facebook_post_uid"
end

Then /^I should see the update form errors$/ do
  within "form.new_update" do
    page.should have_css("label.message[for='update_title']")
    page.should have_css("label.message[for='update_body']")
    page.should have_css("label.message[for='update_lead']")
    page.should have_css("label.message[for='update_share_text']")
  end
end

Then /^I should not see the new update button$/ do
  page.should_not have_css("a#new_update")
end

Then /^I should see the Facebook share button in the update facebox$/ do
  within ".update_facebox" do
    page.should have_css("a.facebook_share")
  end
end

Given /^there is an update for a campaign$/ do
  @campaign = Campaign.make! accepted_at: Time.now
  @update = Update.make! campaign: @campaign
end

Then /^I should see the Twitter share button in the update facebox$/ do
  within ".update_facebox" do
    page.should have_css("a.twitter_share")
  end
end

Then /^I should see the edit button of the update$/ do
  within ".update" do
    page.should have_css("a.edit")
  end
end

Given /^I click in the edit button of the update$/ do
  within ".update" do
    page.find("a.edit").click
  end
end

Given /^I change the update title to "(.*?)"$/ do |arg1|
  within "form.edit_update" do
    fill_in "update_title", with: arg1
  end
end

When /^I submit the edit update form$/ do
  page.find("form.edit_update input[type='submit']").click
end

Then /^the update title should be "(.*?)"$/ do |arg1|
  within ".update_facebox" do
    page.should have_css(".title", text: arg1)
  end
end

Then /^I should see an error in the title field in the edit update form$/ do
  within "form.edit_update" do
    page.should have_css("label.message[for='update_title']")
  end
end

Then /^I should not see the edit button of the update$/ do
  within ".update" do
    page.should_not have_css("a.edit")
  end
end

Then /^I should see the remove update button$/ do
  within ".update" do
    page.should have_css("a.remove")
  end
end

When /^I click on the remove update button$/ do
  within ".update" do
    page.find("a.remove").click
  end
end

Then /^I should not see the update in the list of updates$/ do
  page.should_not have_css(".update .title", text: @update.title)
end

Then /^I should see a successful message$/ do
  page.should have_css("section.notice")
end

Then /^I should not see the remove update button$/ do
  within ".update" do
    page.should_not have_css("a.remove")
  end
end

Then(/^the profile panel should have an option to export all users$/) do
  page.should have_css(".current_user_links a[href='/users.csv']", visible: false)
end

Then(/^the profile panel should not have an option to export all users$/) do
  page.should_not have_css("ul.options a[href='/users.csv']", visible: false)
end

Then(/^I should see "(.*?)" in "(.*?)"$/) do |arg1, arg2|
  within :xpath, to_xpath(arg2) do
    page.should have_xpath(to_xpath(arg1))
  end
end

Given(/^there is an user called "(.*?)"$/) do |arg1|
  User.make! name: arg1
end

Then(/^the campaign's owner should be "(.*?)"$/) do |arg1|
  @campaign.reload.user.email.should be_== arg1
end

Given(/^I own a campaign$/) do
  @campaign = Campaign.make! user: @current_user
end

Given /^I choose "([^"]*)" in the autocomplete$/ do |text|
  step ("I fill \"campaign_user\" with \"#{text}\"")
  page.execute_script "$('.ui-autocomplete-input').trigger('keydown');"
  sleep 2
  page.execute_script "$('.ui-menu-item a:contains(\"#{text}\")').trigger('mouseenter').trigger('click');"
end

Given(/^there is an user with email "(.*?)"$/) do |arg1|
  User.make! email: arg1
end

Then(/^I should see the campaign's hashtag field$/) do
  page.should have_css("form input[name='campaign[hashtag]']")
end

Then(/^I should not see the campaign's hashtag field$/) do
  page.should_not have_css("form input[name='campaign[hashtag]']")
end

Then(/^show me the page$/) do
  save_and_open_page
end

Given(/^I have no phone$/) do
  @current_user.update_attributes phone: nil
end

Given(/^there is a campaign with poke type "(.*?)"$/) do |arg1|
  @campaign = Campaign.make! poke_type: arg1, accepted_at: Time.now, voice_call_script: nil, voice_call_number: nil
end

Then(/^I should receive an email$/) do
  ActionMailer::Base.deliveries.select{|d| d.to.index(@current_user.email) != nil}.should_not be_empty
end

Given(/^I fill in "(.*?)" of "(.*?)" with "(.*?)"$/) do |arg1, arg2, arg3|
  within to_element(arg2) do
    fill_in to_element(arg1), with: arg3
  end
end

Then(/^an email should be sent to "(.*?)"$/) do |arg1|
  ActionMailer::Base.deliveries.select{|d| d.to.index(arg1) != nil}.should_not be_empty
end

Then(/^I should see (\d+) "(.*?)"$/) do |arg1, arg2|
  page.should have_css(to_element(arg2), count: arg1)
end

Then(/^the campaign should have now (\d+) report$/) do |arg1|
  @campaign.reports.count.should be_== arg1.to_i
end
