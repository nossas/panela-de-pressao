module OmniAuth
  module Strategies
    class Meurio < OmniAuth::Strategies::OAuth2
      option :name, :meurio

      option :client_options, {
        :site => "http://meurio.org.br",
        :authorize_path => "/oauth/authorize"
      }

      uid { info['id'].to_s }

      info do
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :meurio, ENV["MEURIO_ID"], ENV["MEURIO_SECRET"]
  provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"], :scope => "email,publish_stream,user_about_me,user_birthday,user_education_history,user_hometown,user_interests,user_location,user_relationships,user_relationship_details,user_religion_politics,user_work_history"
  provider :twitter, ENV["TWITTER_ID"], ENV["TWITTER_SECRET"]
end
