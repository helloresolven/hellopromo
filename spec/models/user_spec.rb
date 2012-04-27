require 'spec_helper'

describe User do
  it { should have_many :shares }
  it { should have_many :redeemed_codes }
end
