require 'net/http'

#
# Region Import task
#
# Usage: rake import_regions
#
task :import_regions => :environment do
  
  puts "Retrieving regions"
  url = "http://geo.craigslist.org/iso/us"
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => 'Mozilla/5.0 (Linux) Gecko/20101203 Firefox/3.6.13' })
  response = http.request(request)
  
  doc = Nokogiri::HTML(response.body)
    
  matches = doc.css("#list a")
  regex = /^http:\/\/(.+).craigslist\.org\/$/
  matches.each do |match|
    href = match.attributes['href'].value
    if href =~ regex
      code = href.match(regex)[1]
    end
    if code
      title = match.content
      region = Region.find_by_code(code)
      if region
        region.update_attribute(:title, title)
      else
        region = Region.create(:code => code, :title => title)
      end
    end
  end
  
end

