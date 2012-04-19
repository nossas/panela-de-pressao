require 'spec_helper'

describe Campaign do
  describe "associations" do
    it{ should belong_to :user }
    it{ should belong_to :organization }
  end
end
