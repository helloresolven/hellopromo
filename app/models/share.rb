class Share < ActiveRecord::Base
  attr_accessible :need_tweet, :share_code, :title, :url, :promoted, :description, :codes
  attr_accessor :codes
  
  belongs_to :owner, :class_name => "User"
  has_many :redeemables
  
  validates :title, presence:true, length:{maximum:65}
  validates :url, presence:true
  
  validates :share_code, presence:true, uniqueness:true, format: { with: /\A\w+\z/, message:"allows only alphanumerics and underscores"}, length: { minimum: 3 }
  
  before_validation :create_share_code_if_needed
  before_save :update_description_html
  after_save :convert_codes
  
  def to_param
    self.share_code
  end
  
  def unredeemed_codes
    Redeemable.where(share_id:self.id, redeemer_id:nil)
  end
  
  def redeemed_codes
    Redeemable.where("share_id = ? AND redeemer_id <> ?", self, nil)
  end
  
  def to_tweet
    %Q{Just got promo code for #{self.title} from @#{self.owner.nickname}! #{self.url}}
  end
  
  private
  def create_share_code_if_needed
    return if self.share_code.present?
    require 'digest/sha2'
    self.share_code = Digest::SHA2.hexdigest("#{Time.now}-#{self.title}-#{self.url}").last(6)
  end
  
  def update_description_html
    self.description_html = Kramdown::Document.new(self.description).to_html if self.description
  end
  
  def convert_codes
    if self.codes
      self.codes.split.each { |code| self.redeemables.create(code:code) }
    end
    
    self.codes = nil
  end
end
