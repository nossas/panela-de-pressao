Feature: View a member profile
  In order to know more how a member interacts on the platform
  as an user
  I want to view a member profile


  Scenario: I'm a visitor and I see an user who poked 1 campaign multiple times
    Given there is a campaign called "Queremos bicicletários em todo o planeta!"
    And there is 1 poker called "Luiz Fonseca" that poked 34 times
    And I'm in the campaigns page
    When I click "Queremos bicicletários em todo o planeta!" within highlight campaign
    And I click on the "Luiz Fonseca" avatar
    Then I should see "O que o Luiz Fonseca já fez no Panela de Pressão"
    #And I should see "Luiz pressionou a campanha Queremos bicicletários em todo o planeta! 34 vezes" 


