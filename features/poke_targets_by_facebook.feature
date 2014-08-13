Feature: Poke targets by Facebook
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Facebook

  @omniauth_test @koala
  Scenario: when I have a Facebook authorization
    Given I'm logged in
    And there is a campaign with poke type "facebook"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "the Facebook poke button"
    Then a facebook poke should be added to the target
    And an email should be sent

  @omniauth_test @koala
  Scenario: when I poke a campaign twice
    Given I'm logged in
    And there is a campaign with poke type "facebook"
    And there is a target for this campaign
    And I already poked this campaign 2 days ago
    And I'm in this campaign page
    When I press "the Facebook poke button"
    Then an email should be sent

  @omniauth_test @koala
  Scenario: when I'm not logged in
    Given there is a campaign with poke type "facebook"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "the Facebook poke button"
    Then a facebook poke should be added to the target
    And an email should be sent
