# coding: utf-8
require 'machinist/active_record'

User.blueprint do
  name { "Test User" }
  email { "foo#{sn}@bar.com" }
  picture { "pic.png" }
end

Authorization.blueprint do
  user { User.make! }
  uid  { "uid#{sn}" }
  provider { 'meurio' }
  token { 'lsjdljasdljas' }
  secret { 'sjdkahjskd' }
end

Campaign.blueprint do
  name { "Desarmamento Voluntário" }
  description { "O projeto desenvolve atividades destinadas a reduzir a violência armada." }
  user { User.make! }
  image { File.open(File.dirname(__FILE__) + "/../../features/support/campaign.png") }
  category { Category.make! }
  organizations(1)
end

Category.blueprint do
  name { "Categoria #{sn}" }
end

Target.blueprint do
  influencer { Influencer.make! }
  campaign { Campaign.make! }
end

Influencer.blueprint do
  name { "Eduardo Paes" }
  email { "eduardopaes@meurio.org.br" }
  twitter { "eduardopaes_" }
  facebook { "http://www.facebook.com/eduardopaesRJ" }
  role { "Prefeito" }
end

Post.blueprint do
  campaign { Campaign.make! }
  content { "testing posts" }
end

Organization.blueprint do
  name { "MeuRio" }
  owner { User.make! }
  avatar { File.open(File.dirname(__FILE__) + "/../../features/support/campaign.png") }
end

Poke.blueprint do
  campaign { Campaign.make! }
  user { User.make! }
  kind { "facebook" }
end
