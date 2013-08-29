Feature: View unmoderated campaigns
  In order to choose a campaign to moderate
  As an admin
  I want to view the unmoderated campaigns

  @omniauth_test @javascript
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to the campaigns page
    And I open my profile options
    When I click "Moderar campanhas"
    Then I should be in the unmoderated campaigns page
    And I should see "Save the whales!"
    And I should see "the cooker's email" in "the campaign list"
    And I should see "the submition date" in "the campaign list"
    And I should see the moderate button for this campaign

  @omniauth_test @javascript
  Scenario: when there is a campaign with a moderator
    Given there is an unmoderated campaign called "Save the whales!" moderated by "Jack Daniel"
    And I'm logged in as admin
    And I go to the campaigns page
    And I open my profile options
    When I click "Moderar campanhas"
    Then I should see "Jack Daniel" as the moderator of this campaign
