Feature: view campaigns by moderator

  Scenario: when there is no moderator
    When I go to "the homepage"
    Then I should not see "any moderation list"

  Scenario: when there is at least one moderator
    Given there is a user
    And there is a campaign moderated by this user
    When I go to "the homepage"
    Then I should see "somebody's moderation list"
