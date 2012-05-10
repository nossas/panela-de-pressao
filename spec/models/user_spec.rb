require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :authorizations }
    it { should have_many :campaigns }
    it { should have_many :organizations }
  end
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
  end
end
