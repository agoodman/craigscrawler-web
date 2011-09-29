class Feed < ActiveRecord::Base

  belongs_to :user
  has_many :items, :dependent => :destroy, :order => 'published_at desc', :limit => 100
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :filters
  
  validates_presence_of :user_id, :region, :category
  
  attr_accessible :region, :category, :scope

  def last_item_published_at
    if items.empty?
      Date.new(2000)
    else
      items.first.published_at unless items.empty?
    end
  end

  def scope
    if attributes['scope']
      attributes['scope']
    else
      "A"
    end
  end
  
  def item_count
    items.count
  end
  
  def load_items
    params = { :region => region, :category => category, :scope => scope, :id => id }
    params[:keywords] = keywords.collect {|k| k.value}.join(" ")
    params[:filters] = Hash[filters.collect {|f| [f.key,f.value]}]
    Feed.retrieve_items(params, 0, false)
  end

  def self.retrieve_items(feed, start = 0, temporary = false)
    if feed[:scope]
      scope = feed[:scope]
    else
      scope = "A"
    end
    if feed[:keywords]
      keywords = feed[:keywords].split(' ').join("+")
    else
      keywords = ""
    end
    if feed[:filters]
      # filters = feed[:filters].keys.collect {|f| "#{f}=#{feed[:filters][f.to_sym]}"}.join("&")
      filters = feed[:filters].keys.collect {|f| "#{f}=#{feed[:filters][f]}"}.join("&")
    else
      filters = ""
    end
    
    puts "region: #{feed[:region]}\tcategory: #{feed[:category]}\tscope: #{scope}\tkeywords: #{keywords}\tfilters: #{filters}"
    if keywords == "" && filters == ""
      # handle case where no keywords or filters are sent
      url = "http://#{feed[:region]}.craigslist.org/#{feed[:category]}/index.rss"
    elsif start!=0
      # client requested a start index, so send it to CL
      url = "http://#{feed[:region]}.craigslist.org/search/#{feed[:category]}?query=#{keywords}&srchType=#{scope}&#{filters}&s=#{start}&format=rss".gsub(/ /,"+")
    else      
      # no start index given, so don't send one to CL
      url = "http://#{feed[:region]}.craigslist.org/search/#{feed[:category]}?query=#{keywords}&srchType=#{scope}&#{filters}&format=rss".gsub(/ /,"+")
    end
    puts "Fetching #{url}"
    rss = Feedzirra::Feed.fetch_and_parse(url, :max_redirects => 10)
    # cutoff_date = @feed.last_item_published_at
    # new_entries = rss.entries.select {|e| e.published > cutoff_date}
    if rss!=0
      new_entries = rss.entries
      puts "Found #{rss.entries.size} entries"
      housing_regex = /(.+) \$(\d+) ?(.*)/
      location_price_regex = /(.+) \((.+)\) ?\$?(\d+)?/
      location_regex = /(.+) \((.+)\)/
      items = new_entries.map do |e| 
        # if e.title =~ location_price_regex
        #   Item.new(:title => e.title.match(location_price_regex)[1], :price => e.title.match(location_price_regex)[3], :location => e.title.match(location_price_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
        # elsif e.title =~ location_regex
        #   Item.new(:title => e.title.match(location_regex)[1], :location => e.title.match(location_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
        # elsif e.title =~ housing_regex
        #     Item.new(:title => e.title.match(housing_regex)[1], :price => e.title.match(housing_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
        # else
        #   Item.new(:title => e.title, :summary => e.summary, :link => e.url, :published_at => e.published)
        # end
        if temporary
          if e.title =~ location_price_regex
            Item.new(:title => e.title.match(location_price_regex)[1], :price => e.title.match(location_price_regex)[3], :location => e.title.match(location_price_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
          elsif e.title =~ location_regex
            Item.new(:title => e.title.match(location_regex)[1], :location => e.title.match(location_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
          elsif e.title =~ housing_regex
              Item.new(:title => e.title.match(housing_regex)[1], :price => e.title.match(housing_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
          else
            Item.new(:title => e.title, :summary => e.summary, :link => e.url, :published_at => e.published)
          end
        else
          if e.title =~ location_price_regex
            Item.create(:feed_id => feed[:id], :title => e.title.match(location_price_regex)[1], :price => e.title.match(location_price_regex)[3], :location => e.title.match(location_price_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
          elsif e.title =~ location_regex
            Item.create(:feed_id => feed[:id], :title => e.title.match(location_regex)[1], :location => e.title.match(location_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
          elsif e.title =~ housing_regex
              Item.create(:feed_id => feed[:id], :title => e.title.match(housing_regex)[1], :price => e.title.match(housing_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
          else
            Item.create(:feed_id => feed[:id], :title => e.title, :summary => e.summary, :link => e.url, :published_at => e.published)
          end
        end
      end
    else
      items = []
    end
    
    return items
  end
  
end
