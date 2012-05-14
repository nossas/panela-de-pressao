require 'spec_helper'

describe Post do
  describe "associations" do
    it{ should belong_to :campaign }
  end

  describe "validations" do
    it{ should validate_presence_of :campaign_id } 
    it{ should validate_presence_of :content } 
  end
end
