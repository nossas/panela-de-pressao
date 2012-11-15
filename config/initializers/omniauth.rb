Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"], :scope => "email,publish_stream,user_about_me,user_birthday,user_education_history,user_hometown,user_interests,user_location,user_relationships,user_relationship_details,user_religion_politics,user_work_history"
  provider :twitter, ENV["TWITTER_ID"], ENV["TWITTER_SECRET"]
end
