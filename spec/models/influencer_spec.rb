require 'spec_helper'

describe Influencer do
  describe "associations" do
    it { should have_many :targets }
    it { should have_many :campaigns }
  end
  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :role }
  end
end
