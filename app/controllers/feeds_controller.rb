class FeedsController < ApplicationController
  
  before_filter :authenticate
  
  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.includes(:keywords).where(:user_id => current_user.id)

    respond_to do |format|
      format.html
      format.json { render :json => @feeds.to_json(:include => :keywords) }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.includes(:keywords).find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @feed.to_json(:include => [:keywords,:items]) }
    end
  end

  # GET /feeds/new
  def new
    @feed = Feed.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(params[:feed])
    @feed.user_id = current_user.id

    respond_to do |format|
      if @feed.save
        format.html { redirect_to(@feed, :notice => 'Feed was successfully created.') }
        format.json { render :json => @feed, :status => :ok, :location => @feed }
      else
        format.html { render :action => "new" }
        format.json { render :json => { :errors => @feed.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to(@feed, :notice => 'Feed was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => { :errors => @feed.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to(feeds_path) }
      format.json { head :ok }
    end
  end
  
end
