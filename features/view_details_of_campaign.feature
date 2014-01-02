Feature: View a campaign's detail
  In order to know better a campaign
  as a citizen
  I want to see a campaigns' detail

  Scenario: when there is an accepted campaign 
    Given there is a campaign called "Desarmamento Voluntário" accepted on "1/1/2012"
    When I go to "this campaign page"
    Then I should see the campaigns' name
    And I should see the campaigns' description 
    And I should see the campaigns' image

  @omniauth_test
  Scenario: when I'm the owner of an unmoderated campaign
    Given I'm logged in
    And I own a campaign called "Desarmamento Voluntário" awaiting moderation
    When I go to "this campaign page"
    Then I should see the campaigns' name
    And I should see the campaigns' description 
    And I should see the campaigns' image
