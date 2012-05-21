Before('@bitly') do
  bitly = Bitly.new('bitly id', 'bitly key')
  bitly.stub(:shorten).and_return(Campaign.make!(:short_url => 'short_url'))
  Bitly.stub(:new).and_return(bitly)
end

