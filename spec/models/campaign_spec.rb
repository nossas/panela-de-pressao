require 'spec_helper'

describe Campaign do
  describe "associations" do
    it{ should belong_to :user }
    it{ should belong_to :organization }
    it{ should belong_to :category }
  end
end
