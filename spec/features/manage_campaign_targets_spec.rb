require 'spec_helper'

feature 'Manage campaign targets', :type => :feature do
  xit 'should add the new target', js: true do
    @user = User.make!
    Authorization.make! user: @user
    @influencer = Influencer.make!
    page.set_rack_session('cas' => {'user' => @user.email})

    visit new_campaign_path
    fill_in :influencer_typeahead, with: @influencer.name
    sleep(1)
    execute_script("$('.tt-suggestion').click();")

    expect(page).to have_css('.influencer-field-name', text: @influencer.name)
  end

  xit 'should remove the target', js: true do
    @user = User.make! admin: true
    @campaign = Campaign.make!
    @influencer = @campaign.influencers.first
    page.set_rack_session('cas' => {'user' => @user.email})

    visit edit_campaign_path(@campaign)
    click_link "remove-influencer-#{@influencer.id}"

    expect(page).to_not have_css('.influencer-field-name', text: @influencer.name)
  end
end
