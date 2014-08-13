Feature: Poke targets by email
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by email

  Scenario: when I'm logged in
    Given I'm logged in
    And there is a campaign with poke type "email"
    And there is a target for this campaign
    And I go to "this campaign page"
    When I press "the email poke button"
    Then an email poke should be added to the target
    And I should receive an email

  Scenario: when I'm not logged in
    Given there is a campaign with poke type "email"
    And there is a target for this campaign
    And I go to "this campaign page"
    And I fill in "the first name field" of "the email poke form" with "Josias"
    And I fill in "the last name field" of "the email poke form" with "Schneider"
    And I fill in "the email field" of "the email poke form" with "teste@meurio.org.br"
    When I press "the email poke button"
    Then an email poke should be added to the target
    And an email should be sent to "teste@meurio.org.br"

  @javascript
  Scenario: when I'm not logged in and I miss the form
    Given there is a campaign with poke type "email"
    And there is a target for this campaign
    And I go to "this campaign page"
    When I press "the email poke button"
    Then I should see "the first name field error"
    And I should see "the last name field error"
    And I should see "the email field error"

  Scenario: when I already poked less than 24 hours ago
    Given I'm logged in
    And there is a campaign with poke type "email"
    And there is a target for this campaign
    And I already poked this campaign 0 days ago
    When I go to "this campaign page"
    Then I should not see "the campaign poke by email form"
    And I should see "the campaign share buttons"
