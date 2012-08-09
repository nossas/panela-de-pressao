Feature: Poke targets by Facebook
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Facebook

  @omniauth_test @koala @javascript
  Scenario: when I have a Facebook authorization
    Given I'm logged in
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I already poked this campaign
    And I'm in this campaign page
    When I press "Pressionar pelo Facebook"
    Then I should see "Muito bom! Você pressionou pelo Facebook."
    And a facebook poke should be added to the target

  @omniauth_test @koala @javascript
  Scenario: when I don't have a Facebook authorization
    Given I'm logged in with Meu Rio
    And there is a campaign called "Impeça a demolição da praça Nossa Senhora da Paz"
    And there is a target for this campaign
    And I already poked this campaign
    And I'm in this campaign page
    When I press "Pressionar pelo Facebook"
    Then I should see "Muito bom! Você pressionou pelo Facebook."
    And a facebook poke should be added to the target
