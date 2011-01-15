class Feeds::KeywordsController < ApplicationController

  before_filter :authenticate
  before_filter :can_access_feed?
  
  def create
    @keyword = @feed.keywords.new(params[:keyword])
    if @keyword.save
      flash[:notice] = 'Keyword added.'
      redirect_to @feed
    else
      flash[:alert] = @keyword.errors.full_messages.join('<br/>')
      redirect_to new_feed_keyword_path(@feed)
    end
  end
  
  def destroy
    @keyword = Keyword.find(params[:id])
    @keyword.destroy
    redirect_to @feed
  end
  
  private
  
  def can_access_feed?
    @feed = Feed.find(params[:feed_id])
    deny_access unless @feed.user_id.to_i == current_user.id.to_i
  end
  
end
