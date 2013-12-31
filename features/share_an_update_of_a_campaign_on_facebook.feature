Feature: share an update of a campaign on Facebook
  In order to tell my friends something new
  As a visitor
  I want to share an update of a campaign on Facebook

  @koala @javascript
  Scenario: the only one I know
    Given there is a campaign
    And there is an update for this campaign
    When I'm in this update page
    Then I should see the Facebook share button in the update facebox
