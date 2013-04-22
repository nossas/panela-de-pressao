Feature: View a member profile
  In order to know more how a member interacts on the platform
  as an user
  I want to view a member profile

  Scenario: I'm a visitor and I see an user who poked 1 campaign multiple times
    Given there is a campaign called "Queremos bicicletários em todo o planeta!"
    And there is 1 poker called "Luiz Fonseca" that poked 1 times
    And I'm in this campaign page
    When I click on the "Luiz Fonseca" avatar
    Then I should see "Pressionou a campanha Queremos bicicletários em todo o planeta!" 
    And I should not see "user[email]"
  
  @omniauth_test @koala
  Scenario: I'm a logged user and I want to see my profile
    Given there is a campaign created by "Luiz Fonseca" with no partnership
    And I'm logged in
    And I'm in this campaign page
    When I click "Meu perfil"
    Then I should see "user[name]"
    And I should see "user[email]"

  Scenario: When the user collaborated with a campaign
    Given there is a user
    And this user collaborated with a campaign called "Queremos bicicletários em todo o planeta!"
    When I go to this user page
    Then I should see "Queremos bicicletários em todo o planeta!"
