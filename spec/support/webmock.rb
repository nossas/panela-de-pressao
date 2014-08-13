RSpec.configure do |config|
  config.before do
    stub_request(:get, "http://graph.facebook.com/eduardopaesRJ").
      to_return(:status => 200, :body => "{\"can_post\":true}", :headers => {})

    stub_request(:post, "http://www.meurio-dev.org.br/rewards.json").
      to_return(:status => 200, :body => "", :headers => {})

    stub_request(:post, /http\:\/\/\/users\/\d+\/memberships\.json/).
      to_return(:status => 200, :body => "", :headers => {})

    stub_request(:get, "http://www.twilio.com/?destination=552197137471&user=552199999999").
      to_return(:status => 200, :body => "", :headers => {})
  end
end
