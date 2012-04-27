class User < ActiveRecord::Base
  attr_accessible nil
  
  validates :uid, uniqueness:true, presence:true
  
  def self.create_with_omniauth(auth)
    self.create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end
  
  has_many :shares, :foreign_key => "owner_id"
  has_many :redeemed_codes, :class_name => "Redeemable", :foreign_key => "redeemer_id"
  has_many :redeemed_shares, :through => :redeemed_codes, :source => :share
  
  def has_code_for?(share)
    self.redeemed_shares.include? share
  end
  
  def can_tweet?
    Twitter.configure do |config|
      config.oauth_token = self.token
      config.oauth_token_secret = self.secret
    end
    
    begin
      Twitter.verify_credentials
      return true
    rescue Twitter::Error::Unauthorized => e
      return false
    end
  end
  
  def tweet_message(message)
    Twitter.configure do |config|
      config.oauth_token = self.token
      config.oauth_token_secret = self.secret
    end
    
    Twitter.update(message)
  end
end
