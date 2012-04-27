require 'spec_helper'

describe Share do
  subject { Fabricate(:share) }
  
  it { should belong_to :owner }
  it { should have_many :redeemables }
  
  describe "share code" do
    it { should validate_uniqueness_of :share_code }
    
    it "should allow alphanumerics and underscores" do
      subject = Share.create(:share_code => "gif_brewery1")
      subject.errors[:share_code].should be_empty
    end
    
    it "should not allow non-alphanumerics nor non-underscores" do
      subject = Share.create(:share_code => "gif-brewery!")
      subject.errors[:share_code].should_not be_empty
    end
    
    it "should force share_code length to be at least 3" do
      subject = Share.create(:share_code => "gi")
      subject.errors[:share_code].should_not be_empty
    end
    
    it "should create a random share code if creation doesn't have one" do
      subject = Share.create()
      subject.share_code.should be_present
      subject.share_code.length.should eq 6
    end
    
    it "should not touch the share code if it has one" do
      subject.share_code.should eq "gifbrew"
    end
  end
  
  describe "redeemables" do
    it "should know its unredeemed codes" do
      subject.unredeemed_codes.length.should eq 2
      
      code = subject.unredeemed_codes.first
      code.redeemer_id = 1
      code.save
      
      subject.unredeemed_codes.length.should eq 1
      subject.unredeemed_codes.each { |code| code.redeemer.should be_nil }
    end
    
    it "should know its redeemed codes" do
      subject.redeemed_codes.length.should eq 0
      
      code = subject.unredeemed_codes.first
      code.redeemer_id = 1
      code.save
      
      subject.redeemed_codes.length.should eq 1
      subject.redeemed_codes.each { |code| code.redeemer.should_not be_nil }
    end
    
    it "converts anything in self.codes into redeemables on save" do
      expect { 
        subject.codes = "214\n\n1242\n42\n421\n4\n"
        subject.save
      }.to change(subject.unredeemed_codes, :count).by(5)
    end
  end
end
