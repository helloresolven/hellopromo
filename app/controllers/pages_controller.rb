class PagesController < ApplicationController
  before_filter :require_login, :only => :profile
  respond_to :html
  
  def index
  end
  
  def profile
  end
  
  def info
  end
end
