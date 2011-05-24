class Feeds::KeywordsController < ApplicationController

  before_filter :authenticate
  before_filter :can_access_feed?
  
  def create
    @keyword = Keyword.new(params[:keyword])
    
    respond_to do |format|
      if @keyword.save
        @feed.keywords << @keyword unless @feed.keywords.include?(@keyword)
        format.html {
          flash[:notice] = 'Keyword added.'
          redirect_to @feed
        }
        format.json { head :ok }
      else
        flash[:alert] = @keyword.errors.full_messages.join('<br/>')
        redirect_to new_feed_keyword_path(@feed)
      end
    end
  end
  
  def destroy
    @keyword = Keyword.find(params[:id])
    @feed.keywords.delete @keyword
    
    respond_to do |format|
      format.html { redirect_to @feed }
      format.json { head :ok }
    end
  end
  
  private
  
  def can_access_feed?
    @feed = Feed.find(params[:feed_id])
    deny_access unless @feed.user_id.to_i == current_user.id.to_i
  end
  
  private
  
  def deny_access
    respond_to do |format|
      format.html {
        flash[:alert] = 'You do not have access to that feed.'
        redirect_to feeds_path
      }
      format.json { render :json => { :errors => [ 'You do not have access to that feed.' ] }, :status => :unauthorized }
    end
  end
  
end
