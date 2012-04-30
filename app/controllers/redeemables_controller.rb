class RedeemablesController < ApplicationController
  before_filter :require_login
  before_filter :require_share
  before_filter :require_not_disabled
  before_filter :require_not_owner, :except => [:destroy]
  before_filter :require_not_redeemed, :except => [:destroy]
  before_filter :require_has_codes, :except => [:destroy]
  
  def destroy
    notice = "You can't do that."
    
    if current_user == @share.owner
      code = Redeemable.find_by_id(params[:id])
      if code.redeemer.nil?
        code.destroy
        notice = "Code removed."
      end
    end
    
    redirect_to share_path(@share), :notice => notice
  end
  
  def acquire
  end
  
  def redeem    
    unredeemed_codes = @share.unredeemed_codes
    
    code = unredeemed_codes.first
    code.redeemer = current_user
    
    if code.valid?  # ensures that user doesn't already have a key.
      begin
        current_user.tweet_message(@share.to_tweet) if @share.need_tweet && current_user.can_tweet?
        code.save
        redirect_to(share_url(@share), :notice => "Code redeemed! Your code is #{code.code}.")
      rescue Twitter::Error::Unauthorized => e
        redirect_to(share_url(@share), :notice => "Something went wrong with Twitter...")
      end      
    else
      redirect_to(share_url(@share), :notice => "You already have a key, no?")
    end
  end
  
  private
  def require_share
    @share ||= Share.find_by_share_code(params[:share_id] || params[:id])
    redirect_to(root_url, :notice => "No such share exists.") unless @share
  end
  
  def require_not_disabled
    redirect_to(share_url(@share), :notice => "This share has been disabled.") if @share.disabled
  end
  
  def require_not_owner
    redirect_to(share_url(@share), :notice => "You can't redeem your own codes...") if @share.owner == current_user
  end
  
  def require_not_redeemed
    redeemed_codes = @share.redeemed_codes
    redirect_to(share_url(@share), :notice => "You already have a code!") if redeemed_codes.where("redeemer_id = ?", current_user.id).count > 0
  end
  
  def require_has_codes
    unredeemed_codes = @share.unredeemed_codes
    redirect_to(share_url(@share), :notice => "All codes taken :(.") if unredeemed_codes.count == 0
  end
end
