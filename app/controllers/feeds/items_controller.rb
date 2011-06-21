class Feeds::ItemsController < ApplicationController

  before_filter :authenticate
  before_filter :can_access_feed?
  
  def index
    @items = @feed.items
    respond_to do |format|
      format.json { render :json => @items.to_json }
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.json { render :json => @item.to_json }
    end
  end
  
  private
  
  def can_access_feed?
    @feed = Feed.find(params[:feed_id])
    deny_access if @feed.user != current_user
  end
  
  def deny_access
    respond_to do |format|
      format.html { redirect_to feeds_path, :alert => "You are not authorized." }
      format.json { render :json => { :errors => [ "You are not authorized." ] }, :status => :unauthorized }
    end
  end

end
