Feature: share a campaign after poke

  @omniauth_test
  Scenario: when I poke by Facebook
    Given I'm logged in
    And there is a campaign with poke type "facebook"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "the Facebook poke button"
    Then I should be in this campaign page
    And I should see "the campaign share buttons"

  @ssi
  Scenario: when I poke by email
    Given I'm logged in
    And there is a campaign with poke type "email"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "the email poke button"
    Then I should be in this campaign page
    And I should see "the campaign share buttons"

  @omniauth_test
  Scenario: when I poke by Twitter
    Given I'm logged in
    And there is a campaign with poke type "twitter"
    And there is a target for this campaign
    And I'm in this campaign page
    When I press "the Twitter poke button"
    Then I should be in this campaign page
    And I should see "the campaign share buttons"

  @ssi
  Scenario: when I poke by phone
    Given I'm logged in
    And there is an accepted campaign
    And I go to "this campaign page"
    When I press "the phone poke button"
    Then I should be in this campaign page
    And I should see "the campaign share buttons"
