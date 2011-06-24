require 'net/http'

#
# Region Import task
#
# Usage: rake import_regions
#
task :import_regions => :environment do
  
  puts "Retrieving regions by state"
  
  regex = /^http:\/\/(.+).craigslist\.org\/?$/

  Carmen::state_codes.collect {|state| state.downcase}.each do |state|
    
    url = "http://geo.craigslist.org/iso/us/#{state}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => 'Mozilla/5.0 (Linux) Gecko/20101203 Firefox/3.6.13' })
    response = http.request(request)
    
    if response.code.to_i==302
      href = response['location']
      puts "redirect to #{href} for #{state}"
      if href =~ regex
        code = href.match(regex)[1]
      end
      
      if code
        title = Carmen::state_name(state)
        region = Region.find_by_code(code)
        geo = Geocoder.search(title)
        if region
          if geo.count>0
            region.update_attributes(:title => title,
                                    :state => state,
                                    :latitude => geo[0].geometry['location']['lat'],
                                    :longitude => geo[0].geometry['location']['lng'])
          else
            region.update_attributes(:title => title,
                                    :state => state)
          end
        else
          if geo.count>0
            region = Region.create(:code => code, 
                                    :title => title, 
                                    :state => state, 
                                    :latitude => geo[0].geometry['location']['lat'],
                                    :longitude => geo[0].geometry['location']['lng'])
          else
            region = Region.create(:code => code, 
                                    :title => title, 
                                    :state => state)
          end
        end
      else
        puts "couldn't resolve region code (#{href})"
      end
      
      next
    end  

    doc = Nokogiri::HTML(response.body)
    
    matches = doc.css("#list a")
    puts "#{matches.count} matches for #{state}"

    matches.each do |match|
      href = match.attributes['href'].value
      if href =~ regex
        code = href.match(regex)[1]
      end
      if code
        title = match.content
        
        # attempt to find existing region; create if not found
        region = Region.find_by_code(code)
        if region
          geo = Geocoder.search("#{region.title}, #{state}")
          if geo.count>0
            region.update_attributes(:title => title, 
                                    :state => state, 
                                    :latitude => geo[0].geometry['location']['lat'],
                                    :longitude => geo[0].geometry['location']['lng'])
          else
            region.update_attributes(:title => title, 
                                    :state => state)
          end
        else
          geo = Geocoder.search("#{title}, #{state}")
          if geo.count>0
            region = Region.create(:code => code, 
                                    :title => title, 
                                    :state => state, 
                                    :latitude => geo[0].geometry['location']['lat'],
                                    :longitude => geo[0].geometry['location']['lng'])
          else
            region = Region.create(:code => code, 
                                    :title => title, 
                                    :state => state)
          end
        end
      else
        puts "couldn't resolve region code (#{href})"
      end
    end

  end
  
end

