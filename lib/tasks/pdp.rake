# coding: utf-8
require 'csv'
require 'open-uri'
require 'json'

namespace :pdp do
  task :migrate_users_database, [:json_url] => :environment do |t, args|
    puts "migrate_users_database"
    users = JSON.parse(open(args[:json_url]).read)
    users["values"].each do |user|
      new_user = User.find_or_create_by_email(
        user[2],
        email:      user[2], 
        first_name: user[1].split(" ")[0], 
        last_name:  user[1].split(" ")[1],
        avatar:     user[3],
        bio:        user[7],
        phone:      user[9],
        password:   Digest::SHA1.hexdigest(Time.now.to_s)
      )
      Authorization.where(user_id: user[0]).each {|i| i.user_id = new_user.id; i.save}
      Campaign.where(user_id: user[0]).each {|i| i.user_id = new_user.id; i.save}
      CampaignOwner.where(user_id: user[0]).each {|i| i.user_id = new_user.id; i.save}
      Poke.where(user_id: user[0]).each {|i| i.user_id = new_user.id; i.save}
      Update.where(user_id: user[0]).each {|i| i.user_id = new_user.id; i.save}
    end
  end
end
