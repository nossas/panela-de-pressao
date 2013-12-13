Feature: Poke targets by phone
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by phone

  @ssi
  Scenario: when I'm logged in
    Given I'm logged in
    And there is an accepted campaign
    And I go to this campaign page
    When I press "the phone poke button"
    Then I should see "the thanks for poke message"
    And I should receive an email

  Scenario: when I fill the form correctly
  Scenario: when I fill the form wrongly
