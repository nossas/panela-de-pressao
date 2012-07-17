Feature: View a campaign's detail
  In order to know better a campaign
  as a citizen
  I want to see a campaigns' detail

  Scenario: One accepted campaign exists 
    Given there is a campaign called "Desarmamento Voluntário" accepted on "1/1/2012"
    When I go to the campaigns page
    And I click "Desarmamento Voluntário"
    Then I should see the campaigns' name
    Then I should see the campaigns' description 
    Then I should see the campaigns' image
