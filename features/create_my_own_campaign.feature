Feature: Create my own campaign
  In order to mobilize people to my cause
  As a mobilizer
  I want to create my own campaign

  Background:
    Given there is an organization in "Rio de Janeiro"
    And there is an influencer called "Eduardo Paes"

  @omniauth_test @javascript @bitly
  Scenario: when I'm smart enough to successfully fill the new campaign form
    Given I'm logged in
    And I'm in the new campaign page
    And I fill "campaign_name" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I select "Rio de Janeiro" for "campaign_organization_id"
    And I fill "campaign_description" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "campaign_email_text" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "campaign_image"
    And I select "Educação" for "campaign_category_id"
    And I click "Personalizar o compartilhamento do Facebook"
    And I fill "campaign_facebook_share_title" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "campaign_facebook_share_lead" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "campaign_facebook_share_thumb"
    And I select "Eduardo Paes" as a target
    When I press "Criar campanha"
    Then I should be in "the created campaign page"
    And an email called "A sua mobilização está no ar!" should be sent
    And an email called "Nova campanha no Panela de Pressão (Rio de Janeiro)" should be sent
    And the organization from "Rio de Janeiro" should have 1 campaign now

  @omniauth_test @javascript @bitly
  Scenario: when I'm not logged in
    Given I'm in the campaigns page
    And I click "the new campaign button"
    And I fill "campaign_name" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I select "Rio de Janeiro" for "campaign_organization_id"
    And I fill "campaign_description" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "campaign_email_text" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "campaign_image"
    And I select "Educação" for "campaign_category_id"
    And I click "Personalizar o compartilhamento do Facebook"
    And I fill "campaign_facebook_share_title" with "Ajude a praça Nossa Senhora da Paz!"
    And I fill "campaign_facebook_share_lead" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "campaign_facebook_share_thumb"
    And I select "Eduardo Paes" as a target
    And I fill "campaign_user_first_name" with "Nícolas"
    And I fill "campaign_user_last_name" with "Iensen"
    And I fill "campaign_user_email" with "nicolas1535@nossascidades.org"
    And I fill "user_phone" with "(21) 999999999"
    When I press "Criar campanha"
    Then I should be in "the created campaign page"

  @omniauth_test @javascript
  Scenario: when I'm troll enough to let all fields blank
    Given I'm logged in
    And I'm in the new campaign page
    When I press "Criar campanha"
    Then I should see "O título é obrigatório"
    And I should see "Para uma campanha existir ela tem que ter um propósito! Porque essa campanha é importante?"

  @omniauth_test @javascript @bitly
  Scenario: when I leave mobile phone empty
    Given I'm logged in
    And I have no phone
    And I'm in the campaigns page
    And I click "the new campaign button"
    And I fill "campaign_name" with "Evitar que desapareçam com a praça Nossa Senhora da Paz"
    And I fill "campaign_description" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I fill "campaign_email_text" with "A praça é um patrimônio histórico e existem outras soluções para o metro que tomará o seu lugar."
    And I attach an image to "campaign_image"
    And I select "Educação" for "campaign_category_id"
    And I select "Eduardo Paes" as a target
    When I press "Criar campanha"
    Then I should see "Celular é obrigatório"

  @omniauth_test
  Scenario: when I'm an admin
    Given I'm logged in as admin
    When I click "the new campaign button"
    Then I should see the campaign's hashtag field

  @omniauth_test
  Scenario: when I'm not an admin
    Given I'm logged in
    When I click "the new campaign button"
    Then I should not see the campaign's hashtag field
