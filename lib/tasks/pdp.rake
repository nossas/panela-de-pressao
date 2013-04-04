# coding: utf-8
require 'csv'

namespace :pdp do
  desc "Email owners reports"
  task :email_owners_reports => :environment do
    Campaign.accepted.unfinished.where("(? - created_at::date) % 7 = 0", Time.now).each do |campaign|
      CampaignMailer.delay.report(campaign)
    end
  end

  desc "Email campaigns without moderator"
  task :email_campaigns_without_moderator => :environment do
    if Campaign.orphan.unmoderated.unarchived.any?
      CampaignMailer.delay.campaigns_without_moderator
    end
  end

  desc "Email the recommended campaigns to users"
  task :email_recommended_campaigns => :environment do
    if(Date.today.yday % 14 == 10)
      User.subscribers.pokers.each do |user|
        UserMailer.delay.recomendations(user.id)
      end
    end
  end
end
