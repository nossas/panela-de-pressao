Feature: take on a campaing's moderation

  @omniauth_test
  Scenario: when I'm an admin
    Given there is an unmoderated campaign called "Save the whales!"
    And I'm logged in as admin
    And I go to the unmoderated campaigns page
    When I click "Assumir moderação"
    Then I should be in the unmoderated campaigns page
    And I should see "Nícolas Iensen está moderando"
