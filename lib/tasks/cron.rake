require 'net/http'

#
# Hourly/Daily cron task
#
# Usage: rake cron
#
task :cron => :environment do
  
  User.all.each do |user|
    puts "Processing #{user.first_name} #{user.last_name}"
    user.feeds.each do |feed|
      url = "http://#{feed.region}.craigslist.org/search/#{feed.category}?query=#{feed.keywords.collect {|k| k.value}.join("+")}&srchType=A&format=rss".gsub(/ /,"+")
      puts "Fetching #{url}"
      rss = Feedzirra::Feed.fetch_and_parse(url)
      cutoff_date = feed.last_item_published_at
      new_entries = rss.entries.select {|e| e.published > cutoff_date}
      puts "Found #{rss.entries.size} entries (#{new_entries.size} new)"
      new_entries.each do |e|
        feed.items.create(:title => e.title, :link => e.url, :published_at => e.published)
      end
    end
  end

  if Time.now.hour == 0 # run at midnight
    puts "Retrieving categories"
    url = "http://tampa.craigslist.org"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => 'Mozilla/5.0 (Linux) Gecko/20101203 Firefox/3.6.13' })
    response = http.request(request)
    
    doc = Nokogiri::HTML(response.body)
    
    # if we move back to top level scraping, this may be useful
    # top_level_matches = doc.css("#main .col")
    # puts "Found top level categories: "
    # top_level_matches.each do |match|
    #   puts match.attributes['id'].value
    # end
    # puts "---"
    
    ['ccc','hhh','sss','bbb','jjj','ggg'].each do |parent_code|
      parent = Category.find_by_code(parent_code)
      matches = doc.css("#main ##{parent_code}.col .cats a")
      simple_regex = /^(\S\S\S)\/?$/
      complex_regex = /.+category=(\S\S\S)\/?.*/
      matches.each do |match|
        href = match.attributes['href'].value
        if href =~ complex_regex
          code = href.match(complex_regex)[1]
        elsif href =~ simple_regex
          code = href.match(simple_regex)[1]
        end
        if code
          title = match.content
          category = Category.find_by_code(code)
          if ! category
            category = Category.create(:parent_id => parent.id, :code => code, :title => title)
          end
        end
      end
    end
  end
  
end

