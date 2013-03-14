Feature: unsubscribe for campaigns updates

  Scenario: when the right token is given
    Given there is a user
    When I go to this user unsubscribe page
    Then I should see the unsubscription message
