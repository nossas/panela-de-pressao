require 'spec_helper'

describe Campaign do
  describe "associations" do
    it{ should belong_to :user }
    it{ should belong_to :category }
    it{ should have_many :pokes }
    it{ should have_many :influencers }
  end

  describe "validations" do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :description }
    it{ should validate_presence_of :user_id }
    it{ should validate_presence_of :image }
    it{ should validate_presence_of :category }
  end

end
