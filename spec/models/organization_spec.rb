require 'spec_helper'

describe Organization do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe "associations" do
    it { should belong_to :owner }
  end
end
