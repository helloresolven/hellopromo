class SharesController < ApplicationController
  respond_to :html
  
  before_filter :require_login, :except => :show
  before_filter :require_share, :only => [:show, :edit, :update, :destroy]
  before_filter :require_owner, :except => [:show, :new, :create]
  before_filter :require_not_disabled, :only => [:edit, :update, :destroy]
  
  def show
    respond_with @share
  end

  def new
    @share = current_user.shares.build(need_tweet:true)
    respond_with @share
  end

  def edit    
    respond_with @share
  end

  def create    
    @share = current_user.shares.build(params[:share])
    @share.save
    
    respond_with @share
  end

  def update
    @share.update_attributes(params[:share])
    respond_with @share
  end
  
  def destroy
    @share.disabled = true
    @share.unredeemed_codes.each { |code| code.destroy }
    @share.save
    
    redirect_to share_path(@share)
  end
  
  private
  def require_share
    @share ||= Share.find_by_share_code(params[:id])
    redirect_to(root_url, :notice => "No such share exists.") unless @share
  end
  
  def require_owner
    redirect_to(share_path(@share), :notice => "You may not edit this share.") unless @share.owner == current_user
  end
  
  def require_not_disabled
    redirect_to(share_path(@share), :notice => "This share has been disabled.") if @share.disabled
  end
end
