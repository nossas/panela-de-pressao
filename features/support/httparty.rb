Before do
  HTTParty.stub(:get).and_return(true)
  HTTParty.stub(:post).and_return(Net::HTTPCreated.new('1.1', 201, 'OK'))
end
