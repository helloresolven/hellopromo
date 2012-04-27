require 'spec_helper'

describe Redeemable do
  subject { Fabricate(:redeemable) }
  
  it { should belong_to :redeemer }
  it { should belong_to :share }
  
  it "should only allow one redeemable per user per share" do
    share = Fabricate(:share)
    user = Fabricate(:user)
    
    first = share.unredeemed_codes.first
    first.redeemer = user
    first.save.should be_true
    
    second = share.unredeemed_codes.first
    second.redeemer = user
    second.save.should be_false
  end
end
