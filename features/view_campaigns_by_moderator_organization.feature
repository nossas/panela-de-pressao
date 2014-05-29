Feature: view campaigns by moderator organization

  Scenario: when there is no moderator organization
    When I go to "the homepage"
    Then I should not see "any moderation list"

  Scenario: when there is at least one moderator organization
  	Given there is an organization
    And there is an user
    And there is a campaign of this organization moderated by this user
    When I go to "the homepage"
    Then I should see "somebody's moderation list"
