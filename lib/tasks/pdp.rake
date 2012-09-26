# coding: utf-8
require 'csv'

namespace :pdp do
  desc "Export statistics table"
  task :export => :environment do
    Poke.where(:kind => "email").each {|poke| puts "#{poke.user.email}, Pressionou via Email, Campanha, #{poke.campaign.category.name}, #{poke.created_at}, PdP"}
    Poke.where(:kind => "facebook").each {|poke| puts "#{poke.user.email}, Pressionou via Facebook, Campanha, #{poke.campaign.category.name}, #{poke.created_at}, PdP"}
    Poke.where(:kind => "twitter").each {|poke| puts "#{poke.user.email}, Pressionou via Twitter, Campanha, #{poke.campaign.category.name}, #{poke.created_at}, PdP"}
    Campaign.all.each {|campaign| puts "#{campaign.user.email}, Criou, Campanha, #{campaign.category.name}, #{campaign.created_at}, PdP"}
  end
end
