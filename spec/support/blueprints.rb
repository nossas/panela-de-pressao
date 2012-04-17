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
