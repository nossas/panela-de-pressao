require 'spec_helper'

describe Report do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :campaign_id }
end
