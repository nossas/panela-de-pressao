Before('@bitly') do
  bitly = Bitly.new('bitly id', 'bitly key')
  bitly.stub_chain(:shorten, :short_url).and_return("http://localhost:3000/campaigns")
  Bitly.stub(:new).and_return(bitly)
end

