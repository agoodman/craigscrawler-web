#
# Hourly/Daily cron task
#
# Usage: rake cron
#
task :cron => :environment do
  
  User.all.each do |user|
    puts "Processing #{user.first_name} #{user.last_name}"
    user.feeds.each do |feed|
      url = "http://#{feed.region}.craigslist.org/search/#{feed.category}?query=#{feed.keywords.collect {|k| k.value}.join("+")}&srchType=A&format=rss"
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
  
end

