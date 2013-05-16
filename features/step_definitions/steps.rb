# coding: utf-8
Given /^I'm in ([^"]*)$/ do |arg1|
  case arg1
  when "the campaigns page"
    visit campaigns_path
  when "the new campaign page"
    visit new_campaign_path
  when "the influencers page"
    visit influencers_path
  when "the new influencer page"
    visit new_influencer_path
  when "this campaign page"
    visit campaign_path(@campaign)
  when "this campaign editing page"
    visit edit_campaign_path(@campaign)
  when "this target page"
    visit influencer_path(@target.influencer)

  when "the unmoderated campaigns page"
    visit unmoderated_campaigns_path
  when "this user unsubscribe page"
    visit user_unsubscribe_path(@user, :token => @user.token)
  else
    raise "I don't know #{arg1}"
  end
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
  @campaign = Campaign.make! name: arg1, accepted_at: nil, :user => Authorization.find_by_uid("536687842").user
end

Given /^I own a campaign called "([^"]*)"$/ do |arg1|
  @campaign = Campaign.make! name: arg1, :user => Authorization.find_by_uid("536687842").user, :accepted_at => Time.now
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
  visit "/auth/facebook"
  Authorization.find_by_uid("536687842").user.update_attributes :mobile_phone => "(21) 9232-1233"
  visit root_path
end

Given /^I've created an organization called "([^"]*)"$/ do |arg1|
  Organization.make! name: arg1.to_s, owner: Authorization.find_by_uid("536687842").user, accepted: true
end

Given /^I'm logged in as admin$/ do
  visit "/auth/facebook"
  Authorization.find_by_uid("536687842").user.update_attributes :admin => true, :mobile_phone => "(21) 9983-2232"
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
  Authorization.make! :user => Authorization.find_by_uid("536687842").user, :provider => "twitter"
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
  @poke = Poke.make! :campaign => @campaign
end

Given /^I check "(.*?)"$/ do |arg1|
  check(arg1)
end

Then /^I should see "([^"]*)"$/ do |arg1|
  case arg1
  when "the poker avatar"
    page.should have_css("img[src='http://sphotos-d.ak.fbcdn.net/hphotos-ak-snc7/602310_10151152362652843_505953681_n.jpg']")
  when "user[name]"
    page.should have_css('input[name="user[name]"]')
  when "user[email]"
    page.should have_css('input[name="user[email]"]')
  when "user[about_me]"
    page.should have_css('textarea[name="user[about_me]"]')
  when "Pressionar pelo Facebook"
    page.should have_css('input[type="submit"].facebook_poke')
  when "Pressionar pelo Twitter"
    page.should have_css('input[type="submit"].twitter_poke')
  when "the new campaign form"
    page.should have_css("#new_campaign")
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
  elsif arg1 == "Entrar via Facebook"
    within("#login") do
      click_on arg1
    end
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
  else
    page.should_not have_content(arg1)
  end
end

Then /^I should be in ([^"]*)$/ do |arg1|
  case arg1
  when "the campaigns page"
    page.current_path.should be_== campaigns_path
  when "this campaign page"
    page.current_path.should be_== campaign_path(@campaign)
  when "the new campaign page"
    page.current_path.should be_== new_campaign_path
  when "the answers page of the campaign"
    page.current_path.should be_== answers_campaign_path(@campaign)
  when "the unmoderated campaigns page"
    sleep 1
    page.current_path.should be_== unmoderated_campaigns_path
  when "the homepage"
    page.current_path.should be_== root_path
  when "the Facebook callback"
    page.current_path.should be_== '/auth/facebook/callback'
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

Then /^a ([^"]*) poke should be added to the target$/ do |arg1|
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
  page.execute_script("$('.options').show();")
end

Given /^I already poked this campaign$/ do
  Poke.make! :campaign => @campaign, :user => User.find_by_email("nicolas@engage.is")
end

Given /^I pass over the email poke button$/ do
  page.execute_script("$('.email_text').show();")
end

Given /^I pass over the facebook poke button$/ do
  page.execute_script("$('.facebook_text').show();")
end

When /^I press "(.*?)" at "(.*?)"$/ do |arg1, arg2|
  if arg2 == "the facebook poke message"
    within("#facebook_poke_message") do
      click_button arg1
    end
  elsif arg2 == "the email poke message"
    within("#email_poke_message") do
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
  @campaign = Campaign.make! :name => arg1, :accepted_at => nil, :moderator => User.make!(:name => arg2)
end

Given /^there is a user$/ do
  @user = User.make!
end

Given /^this user collaborated with a campaign called "(.*?)"$/ do |arg1|
  @campaign = Campaign.make!(:name => arg1, :accepted_at => Time.now)
  @campaign.users << @user
end

Then /^I should see the moderate button for this campaign$/ do
  page.should have_css("li.campaign a[href='#{campaign_moderate_path(@campaign)}']")
end

Then /^I should see "(.*?)" as the moderator of this campaign$/ do |arg1|
  page.should have_css("li.campaign .campaign_moderator", :text => arg1)
end

Given /^there is a campaign$/ do
  @campaign = Campaign.make!
end

Then /^I should see the unsubscription message$/ do
  page.should have_css(".unsubscription_message")
end
