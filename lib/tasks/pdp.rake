# coding: utf-8
require 'csv'

namespace :pdp do
  desc "Email owners reports"
  task :email_owners_reports => :environment do
    Campaign.accepted.unfinished.where("(? - created_at::date) % 7 = 0", Time.now).each do |campaign|
      CampaignMailer.report(campaign).deliver
    end
  end

  desc "Email campaigns without moderator"
  task :email_campaigns_without_moderator => :environment do
    if Campaign.orphan.unmoderated.unarchived.any?
      CampaignMailer.campaigns_without_moderator.deliver
    end
  end

  desc "Email the recommended campaigns to users"
  task :email_recommended_campaigns => :environment do
    if(Date.today.yday % 14 == 4)
      User.subscribers.each do |user|
        UserMailer.recomendations(user.id).deliver
      end
    end
  end
end
