Before('@koala') do
  Koala::Facebook::API.stub(:new).and_return double(:put_connections => true, :put_wall_post => true, :get_object => {"id" => "1"})
end
