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

  Scenario: One accepted campaign exists and there's 1 organization as partner
    Given there is a campaign called "Desarmamento Voluntário" with an organization "MeuRio" as supporter accepted on "1/1/2012"
    When I go to the campaigns page
    And I click "Desarmamento Voluntário"
    Then I should see an avatar from organization "MeuRio"

  Scenario: One accepted campaign exists and there's 1 organization as partner and 5 people poked an influencer
    Given there is a campaign called "Desarmamento Voluntário" with an organization "MeuRio" as supporter accepted on "1/1/2012"
    And there is 5 pokers for this campaign
    When I go to the campaigns page
    And I click "Desarmamento Voluntário"
    Then I should see "Quem participou"
    Then I should see a list of 5 recent pokers

  Scenario: One accepted campaign exists and there's 1 organization as parter and 3 people poked an influencer more than once
    Given there is a campaign called "Desarmamento Voluntário" with an organization "MeuRio" as supporter accepted on "1/1/2012"
    And there is 1 poker called "Luiz" that poked 25 times
    And there is 1 poker called "Mahadesh" that poked 15 times
    And there is 1 poker called "Babuíno" that poked 5 times
    When I go to the campaigns page
    And I click "Desarmamento Voluntário"
    Then I should see "Participantes mais ativos"
    Then I should see a list with order "Luiz", "Babuíno", "Mahadesh"
