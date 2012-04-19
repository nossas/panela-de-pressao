require 'spec_helper'

describe OrganizationMember do
  describe "validations" do
    it{ should validate_presence_of :user_id }
    it{ should validate_presence_of :organization_id }
  end

  describe "associations" do
    it{ should belong_to :user } 
    it{ should belong_to :organization } 
  end
end
