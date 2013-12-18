Feature: Poke targets by Twitter
  In order to engage influencers to the campaign
  As a citizen
  I want to poke targets by Twitter

  @omniauth_test @twitter @javascript @koala @ssi
  Scenario: when I have a Twitter authorization
    Given I'm logged in
    And there is a campaign with poke type "twitter"
    And there is a target for this campaign
    And I have a Twitter authorization
    And I'm in this campaign page
    When I press "the Twitter poke button"
    Then a twitter poke should be added to the target
    And an email should be sent

  @omniauth_test @twitter @javascript @koala @ssi
  Scenario: when I haven't a Twitter authorization
    Given I'm logged in
    And there is a campaign with poke type "twitter"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "the Twitter poke button"
    Then a tweet poke should be added to the target
    And an email should be sent

  @omniauth_test @twitter @koala @javascript
  Scenario: when I'm not logged in
    Given there is a campaign with poke type "twitter"
    And there is a target for this campaign
    And I'm in this campaign page
    And I fill in "the first name field" of "the Twitter poke form" with "Nícolas"
    And I fill in "the last name field" of "the Twitter poke form" with "Iensen"
    And I fill in "the email field" of "the Twitter poke form" with "nicolas@iensen.me"
    When I press "the Twitter poke button"
    Then a tweet poke should be added to the target
    And an email should be sent

  @javascript @omniauth_test
  Scenario: when I don't fill the form properly
    Given there is a campaign with poke type "twitter"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "the Twitter poke button"
    Then I should see "the first name field error"
    And I should see "the last name field error"
    And I should see "the email field error"
