Feature: view all the reported campaigns

  @javascript @ssi
  Scenario: when I'm logged in as admin
    Given I'm logged in as admin
    When I open my profile options
    Then I should see "the reported campaigns button"
  
  @javascript @ssi
  Scenario: when I'm not logged in as admin
    Given I'm logged in
    When I open my profile options
    Then I should not see "the reported campaigns button"

  @ssi
  Scenario: when there is at least one reported campaign
    Given I'm logged in as admin
    And there is 10 reported campaigns
    When I go to the reported campaigns page
    Then I should see 10 "campaigns"

  @ssi
  Scenario: when there is no reported campaign
    Given I'm logged in as admin
    When I go to the reported campaigns page
    Then I should see "there is no reported campaigns"
