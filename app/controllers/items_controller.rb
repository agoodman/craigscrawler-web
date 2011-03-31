class ItemsController < ApplicationController

  def index
    retrieve_items
    respond_to do |format|
      format.json { render :json => @items.to_json(:only => [:title,:price,:summary,:link,:location,:published_at]) }
    end
  end
  
  private
  
  def retrieve_items
    if params[:feed][:scope]
      scope = params[:feed][:scope]
    else
      scope = "A"
    end
    url = "http://#{params[:feed][:region]}.craigslist.org/search/#{params[:feed][:category]}?query=#{params[:feed][:keywords].split(' ').join("+")}&srchType=#{scope}&format=rss".gsub(/ /,"+")
    if params[:feed][:filters]
      params[:feed][:filters].keys.each do |f|
        url += "&#{f}=#{params[:feed][:filters][f.to_sym]}"
      end
    end
    puts "Fetching #{url}"
    rss = Feedzirra::Feed.fetch_and_parse(url)
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
