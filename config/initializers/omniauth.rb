module OmniAuth::Strategies
  class FacebookAdmin < Facebook
    def name 
      :facebook_admin
    end 
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"], :scope => "email,publish_stream,user_birthday,user_education_history,user_interests,user_location,user_religion_politics"
  provider :twitter, ENV["TWITTER_ID"], ENV["TWITTER_SECRET"]
  provider :facebook_admin, ENV["FB_ID"], ENV["FB_SECRET"], :scope => "email,publish_stream,user_birthday,user_education_history,user_interests,user_location,user_religion_politics,manage_pages"
end
