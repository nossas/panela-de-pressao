Before do
  Gibbon::API.stub_chain(:lists, :segment_add).and_return({"id" => 1})
end
