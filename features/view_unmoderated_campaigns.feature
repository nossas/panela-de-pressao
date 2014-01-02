Feature: View unmoderated campaigns
  In order to choose a campaign to moderate
  As an admin
  I want to view the unmoderated campaigns

  @omniauth_test @javascript @ssi
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to the campaigns page
    And I open my profile options
    When I click "Moderar campanhas"
    Then I should see "the campaign's name" in "the campaign list"
    And I should see "the campaign's user email" in "the campaign list"
    And I should see "the campaign's submition date" in "the campaign list"
    And I should see "the campaign's moderation button" in "the campaign list"

  @omniauth_test @javascript @ssi
  Scenario: when the campaign already has a moderator
    Given there is an campaign called "Save the whales!" moderated by "Jack Daniel"
    And I'm logged in as admin
    And I go to the campaigns page
    And I open my profile options
    When I click "Moderar campanhas"
    Then I should not see "Save the whales!"

