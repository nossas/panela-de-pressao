Feature: View an influencer profile
  In order to know more about an influencer
  As an user
  I want to view an influencer profile

  @koala
  Scenario: I'm a visitor
    Given there is a campaign called "A taça do mundo é nossa" 
    And there is a target for this campaign called "Eduardo Paes"
    And I'm in this campaign page
    When I click "Eduardo Paes"
    Then I should see "Campanhas onde Eduardo Paes foi pressionado"
    And I should see "A taça do mundo é nossa"
    And I should see "Ele é candidato a prefeitura."

  @koala
  Scenario: the influencer is a target on a non-approved campaign
    Given there is a campaign called "Save the Queen" awaiting moderation
    And there is a target for this campaign called "Eduardo Paes"
    When I go to this target page
    Then I should not see "Save the Queen"
