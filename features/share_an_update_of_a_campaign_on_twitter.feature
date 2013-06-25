Feature: share an update of a campaign on Twitter
  In order to tell my friends the news
  As a visitor
  I want to share an update of a campaign on Twitter

  @koala @javascript
  Scenario: the one
    Given there is an update for a campaign
    When I'm in this update page
    Then I should see the Twitter share button in the update facebox
