class ItemsController < ApplicationController

  before_filter :save_query, :only => :index
  
  def index
    @items = Feed.retrieve_items(params[:feed], 0, true)
    respond_to do |format|
      format.json { render :json => @items.to_json(:only => [:title,:price,:summary,:link,:location,:published_at]) }
    end
  end
  
  private
  
  def save_query
    region = params[:feed][:region]
    category = params[:feed][:category]
    if params[:feed][:scope]
      scope = params[:feed][:scope]
    else
      scope = "A"
    end
    query = Query.new(:region => region, :category => category, :scope => scope)
    if query.save
      if params[:feed][:filters]
        params[:feed][:filters].keys.each do |f|
          filter = Filter.find_or_create_by_key_and_value(f, params[:feed][:filters][f.to_sym])
          query.filters << filter
        end
      end
      if ! params[:feed][:keywords].nil?
        params[:feed][:keywords].split(' ').each do |k|
          keyword = Keyword.find_or_create_by_value(k)
          query.keywords << keyword
        end
      end
    else
      Logger.new(STDOUT).warn("unable to save query")
    end
  end
  
  def retrieve_items
    if params[:feed][:scope]
      scope = params[:feed][:scope]
    else
      scope = "A"
    end
    if params[:feed][:keywords]
      keywords = params[:feed][:keywords].split(' ').join("+")
    else
      keywords = ""
    end
    if params[:feed][:filters]
      filters = params[:feed][:filters].keys.collect {|f| "#{f}=#{params[:feed][:filters][f.to_sym]}"}.join("&") + "&"
    else
      filters = ""
    end
    
    if keywords == "" && filters == ""
      # handle case where no keywords or filters are sent
      url = "http://#{params[:feed][:region]}.craigslist.org/#{params[:feed][:category]}/index.rss"
    elsif params[:s]
      # client requested a start index, so send it to CL
      url = "http://#{params[:feed][:region]}.craigslist.org/search/#{params[:feed][:category]}?query=#{keywords}&srchType=#{scope}&#{filters}s=#{params[:s]}&format=rss".gsub(/ /,"+")
    else      
      # no start index given, so don't send one to CL
      url = "http://#{params[:feed][:region]}.craigslist.org/search/#{params[:feed][:category]}?query=#{keywords}&srchType=#{scope}&#{filters}format=rss".gsub(/ /,"+")
    end
    puts "Fetching #{url}"
    rss = Feedzirra::Feed.fetch_and_parse(url, :max_redirects => 10)
    # cutoff_date = @feed.last_item_published_at
    # new_entries = rss.entries.select {|e| e.published > cutoff_date}
    if rss
      new_entries = rss.entries
      puts "Found #{rss.entries.size} entries"
      housing_regex = /(.+) \$(\d+) ?(.*)/
      location_price_regex = /(.+) \((.+)\) ?\$?(\d+)?/
      location_regex = /(.+) \((.+)\)/
      @items = new_entries.map do |e| 
        if e.title =~ location_price_regex
          Item.new(:title => e.title.match(location_price_regex)[1], :price => e.title.match(location_price_regex)[3], :location => e.title.match(location_price_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
        elsif e.title =~ location_regex
          Item.new(:title => e.title.match(location_regex)[1], :location => e.title.match(location_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
        elsif e.title =~ housing_regex
            Item.new(:title => e.title.match(housing_regex)[1], :price => e.title.match(housing_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
        else
          Item.new(:title => e.title, :summary => e.summary, :link => e.url, :published_at => e.published)
        end
      end
    else
      @items = []
    end
  end
  
end
