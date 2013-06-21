Feature: view an update of a campaign
  In order to keep me updated with a campaign
  As a visitor
  I want to view an update of a campaign

  @javascript @koala
  Scenario: when the update have an image
    Given there is an accepted campaign
    And there is an update with an image for this campaign
    And I'm in this campaign page
    And I click in the updates button
    When I click in the update title
    Then I should see the update lightbox
    And I should see the update image

  @javascript @koala
  Scenario: when the update have a video
    Given there is an accepted campaign
    And there is an update with a video for this campaign
    And I'm in this campaign page
    And I click in the updates button
    When I click in the update title
    Then I should see the update lightbox
    And I should see the update video
