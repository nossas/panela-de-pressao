Before('@twitter') do
  Twitter.stub(:update)
end
