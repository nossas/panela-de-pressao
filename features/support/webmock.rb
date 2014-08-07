require 'webmock/cucumber'
WebMock.disable_net_connect!(:allow_localhost => true)

Before do


  stub_request(:get, "http://graph.facebook.com/eduardopaesRJ").
    to_return(:status => 200, :body => "{\"can_post\":true}", :headers => {})
end
