require 'net/http'

#
# Subregion Import task
#
# Usage: rake import_subregions
#
task :import_subregions => :environment do
  
  puts "Retrieving subregions by region"
  
  regex = /\/(.+)\//
  
  Region.all.each do |region|
    
    url = "http://#{region.code}.craigslist.org"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => 'Mozilla/5.0 (Linux) Gecko/20101203 Firefox/3.6.13' })
    response = http.request(request)
    
    if response.code.to_i==302
      href = response['location']
      puts "redirect to #{href} for #{region.code}"
      next
    end

    doc = Nokogiri::HTML(response.body)
    
    matches = doc.css("#topban .sublinks a")
    puts "#{matches.count} matches for #{region.code}"

    matches.each do |match|
      href = match.attributes['href'].value
      if href =~ regex
        code = href.match(regex)[1]
      end
      if code
        Subregion.create(:region_id => region.id, :code => code, :title => match.attributes['title'].value)
      else
        puts "couldn't resolve region code (#{href})"
      end
    end

  end
  
end

