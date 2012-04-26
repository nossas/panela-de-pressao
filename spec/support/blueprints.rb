# coding: utf-8
require 'machinist/active_record'

User.blueprint do
  name { "Test User" }
  email { "foo#{sn}@bar.com" }
end

Authorization.blueprint do
  user { User.make! }
  uid  { "uid#{sn}" }
  provider { 'meurio' }
end

Campaign.blueprint do
  name { "Desarmamento Voluntário" }
  description { "O projeto desenvolve atividades destinadas a reduzir a violência armada." }
  user { User.make! }
  image { File.open(File.dirname(__FILE__) + "/../../features/support/campaign.png") }
end

Category.blueprint do
  name { "Categoria #{sn}" }
end
