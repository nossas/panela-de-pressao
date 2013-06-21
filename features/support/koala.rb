Before('@koala') do
  page_graph = double(:put_connections => {"id" => "facebook_post_uid"})
  user_graph = double(
    :get_page_access_token => "page_token",
    :put_connections => true, 
    :put_wall_post => true, 
    :get_object => {
      "id" => "1", 
      "can_post" => true, 
      "link" => "http://www.facebook.com/eduardopaesRJ"
    }
  )
  Koala::Facebook::API.stub(:new).and_return user_graph
  Koala::Facebook::API.stub(:new).with("ASFGHJGHFGDSFDFGHDGF").and_return user_graph
  Koala::Facebook::API.stub(:new).with("page_token").and_return page_graph
end
