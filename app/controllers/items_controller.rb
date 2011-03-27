class ItemsController < ApplicationController

  def index
    retrieve_items
    respond_to do |format|
      format.json { render :json => @items.to_json(:only => [:title,:price,:summary,:link,:published_at]) }
    end
  end
  
  private
  
  def retrieve_items
    url = "http://#{params[:feed][:region]}.craigslist.org/search/#{params[:feed][:category]}?query=#{params[:feed][:keywords].split(' ').join("+")}&srchType=A&format=rss".gsub(/ /,"+")
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
      puts "Found #{rss.entries.size} entries (#{new_entries.size} new)"
      regex = /(.+) (\$\d+) (.+)/
      @items = new_entries.map do |e| 
        if e.title =~ regex
          Item.new(:title => e.title.match(regex)[1], :price => e.title.match(regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
        else
          Item.new(:title => e.title, :summary => e.summary, :link => e.url, :published_at => e.published)
        end
      end
    else
      @items = []
    end
  end
  
end
