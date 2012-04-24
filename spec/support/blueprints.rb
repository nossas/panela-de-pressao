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
end
