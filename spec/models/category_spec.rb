require 'spec_helper'

describe Category do
  describe "validations" do
    before{ Category.make! }
    it{ should validate_presence_of :name }
    it{ should validate_uniqueness_of :name }
  end
end
