Before do
  Gibbon::API.stub_chain(:lists, :segment_add).and_return({"id" => 1})
  Gibbon::API.stub_chain(:lists, :subscribe)
  Gibbon::API.stub_chain(:lists, :static_segment_members_add)
end
