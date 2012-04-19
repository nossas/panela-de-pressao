require 'spec_helper'

describe Issue do
  describe "associations" do
    it{ should belong_to :user }
    it{ should belong_to :organization }
  end
end
