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
    Given there is an accepted campaign
    And I go to this campaign page
    And I fill in "the first name field" of "the phone poke form" with "Nícolas"
    And I fill in "the last name field" of "the phone poke form" with "Iensen"
    And I fill in "the email field" of "the phone poke form" with "nicolas@meurio.org.br"
    And I fill in "the phone field" of "the phone poke form" with "(21) 999999999"
    When I press "the phone poke button"
    Then I should see "the thanks for poke message"
    And an email should be sent to "nicolas@meurio.org.br"
   
  Scenario: when I fill the form wrongly
