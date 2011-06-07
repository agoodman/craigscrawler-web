task :geocode => :environment do
  
  Region.all.each do |region|
    geo = Geocoder.search(region.title)
    if geo.count>0
      region.latitude = geo[0].geometry['location']['lat']
      region.longitude = geo[0].geometry['location']['lng']
      region.save
    end
  end
  
end
