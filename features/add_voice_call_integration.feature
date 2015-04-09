Feature: Enable voice call integration of campaign
  In order to allow people to connect directly with their representatives
  As an admin
  I want to enable voice call integration

  Background:
    Given there is an organization in "Rio de Janeiro"
    And there is an influencer called "Eduardo Paes"

  @omniauth_test
  Scenario: when I own a campaign
    Given I'm logged in
    When I'm in the new campaign page
    Then I should not see "the Plivo integration fields"

  @omniauth_test
  Scenario: when I'm admin
    Given I'm logged in as admin
    When I'm in the new campaign page
    Then I should see "the Plivo integration fields"

  @omniauth_test @javascript @bitly
  Scenario: when I'm smart enough to successfully fill the new campaign form
    Given I'm logged in as admin
    And I'm in the new campaign page
    And I fill "campaign_name" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I select "Rio de Janeiro" for "campaign_organization_id"
    And I fill "campaign_description" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "campaign_email_text" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I click "Adicionar pressão via telefone"
    And I fill "campaign_voice_call_script" with "Script with"
    And I fill "campaign_voice_call_number" with "2197137471"
    And I attach an image to "campaign_image"
    And I select "Educação" for "campaign_category_id"
    And I select "Eduardo Paes" as a target
    When I press "Criar mobilização"
    Then I should be in "the created campaign page"
    And an email called "A sua mobilização está no ar!" should be sent
