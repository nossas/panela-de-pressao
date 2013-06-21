# coding: utf-8
require 'machinist/active_record'

User.blueprint do
  name { "Test User" }
  email { "foo#{sn}@bar.com" }
  picture { "http://sphotos-d.ak.fbcdn.net/hphotos-ak-snc7/602310_10151152362652843_505953681_n.jpg" }
  admin { false } 
  mobile_phone { "(21) 9999-9999" }
end

Authorization.blueprint do
  user { User.make! }
  uid  { "uid#{sn}" }
  provider { 'meurio' }
  token { 'lsjdljasdljas' }
  secret { 'sjdkahjskd' }
end

Campaign.blueprint do
  name { "Desarmamento Voluntário #{sn}" }
  description { "O projeto desenvolve atividades destinadas a reduzir a violência armada." }
  user { User.make! }
  image { File.open(File.dirname(__FILE__) + "/../../features/support/campaign.png") }
  category { Category.first }
  pokes(0)
  email_text { "teste" }
  facebook_text { "teste" }
  twitter_text { "teste" }
  map_embed  { '<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps/ms?ie=UTF8&amp;msa=0&amp;msid=217057435688440890390.0004c5805d208053b7e14&amp;t=m&amp;z=4"></iframe><br /><small><a href="https://maps.google.com/maps/ms?ie=UTF8&amp;msa=0&amp;msid=217057435688440890390.0004c5805d208053b7e14&amp;t=m&amp;z=4&amp;source=embed" style="color:#0000FF;text-align:left">View Larger Map</a></small>' }
  map_description { "My Map Description" }
  preview_code { "12345" }
  voice_call_script { "Script" }
  voice_call_number { "2197137471" }
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
  twitter { "@eduardopaes_" }
  facebook_id { "1212313" }
  facebook_url { "http://www.facebook.com/eduardopaesRJ" }
  role { "Prefeito" }
  about { "Ele é candidato a prefeitura." }
end

Poke.blueprint do
  campaign { Campaign.make! }
  user { User.make! }
  kind { "email" }
end
