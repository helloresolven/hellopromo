class Redeemable < ActiveRecord::Base
  attr_accessible :code
  
  belongs_to :share
  belongs_to :redeemer, :class_name => "User"
  
  validates :redeemer_id, uniqueness: {scope: :share_id, allow_nil: true}
end
