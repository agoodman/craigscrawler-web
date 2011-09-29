class Feed < ActiveRecord::Base

  belongs_to :user
  has_many :items, :dependent => :destroy, :order => 'published_at desc', :limit => 100
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :filters
  
  validates_presence_of :user_id, :region, :category
  
  attr_accessible :region, :category, :scope

  REGIONS = { 
    'abilene' => 'abilene',
    'akroncanton' => 'akron / canton',
    'albany' => 'albany',
    'albanyga' => 'albany, GA',
    'albuquerque' => 'albuquerque',
    'altoona' => 'altoona-johnstown',
    'amarillo' => 'amarillo',
    'ames' => 'ames, IA',
    'anchorage' => 'anchorage / mat-su',
    'annarbor' => 'ann arbor',
    'annapolis' => 'annapolis',
    'appleton' => 'appleton-oshkosh-FDL',
    'asheville' => 'asheville',
    'ashtabula' => 'ashtabula',
    'athensga' => 'athens, GA',
    'athensohio' => 'athens, OH',
    'atlanta' => 'atlanta',
    'auburn' => 'auburn',
    'augusta' => 'augusta',
    'austin' => 'austin',
    'bakersfield' => 'bakersfield',
    'baltimore' => 'baltimore',
    'batonrouge' => 'baton rouge',
    'battlecreek' => 'battle creek',
    'beaumont' => 'beaumont / port arthur',
    'bellingham' => 'bellingham',
    'bemidji' => 'bemidji',
    'bend' => 'bend',
    'billings' => 'billings',
    'binghamton' => 'binghamton',
    'bham' => 'birmingham, AL',
    'bismarck' => 'bismarck',
    'bloomington' => 'bloomington, IN',
    'bn' => 'bloomington-normal',
    'boise' => 'boise',
    'boone' => 'boone',
    'boston' => 'boston',
    'boulder' => 'boulder',
    'bgky' => 'bowling green',
    'bozeman' => 'bozeman',
    'brainerd' => 'brainerd',
    'brownsville' => 'brownsville',
    'brunswick' => 'brunswick, GA',
    'buffalo' => 'buffalo',
    'butte' => 'butte',
    'capecod' => 'cape cod / islands',
    'catskills' => 'catskills',
    'cedarrapids' => 'cedar rapids',
    'cnj' => 'central NJ',
    'cenla' => 'central louisiana',
    'centralmich' => 'central michigan',
    'chambana' => 'champaign urbana',
    'charleston' => 'charleston, SC',
    'charlestonwv' => 'charleston, WV',
    'charlotte' => 'charlotte',
    'charlottesville' => 'charlottesville',
    'chattanooga' => 'chattanooga',
    'chautauqua' => 'chautauqua',
    'chicago' => 'chicago',
    'chico' => 'chico',
    'chillicothe' => 'chillicothe',
    'cincinnati' => 'cincinnati, OH',
    'clarksville' => 'clarksville, TN',
    'cleveland' => 'cleveland',
    'clovis' => 'clovis / portales',
    'collegestation' => 'college station',
    'cosprings' => 'colorado springs',
    'columbiamo' => 'columbia / jeff city',
    'columbia' => 'columbia, SC',
    'columbus' => 'columbus',
    'columbusga' => 'columbus, GA',
    'cookeville' => 'cookeville',
    'corpuschristi' => 'corpus christi',
    'corvallis' => 'corvallis/albany',
    'chambersburg' => 'cumberland valley',
    'dallas' => 'dallas / fort worth',
    'danville' => 'danville',
    'dayton' => 'dayton / springfield',
    'daytona' => 'daytona beach',
    'decatur' => 'decatur, IL',
    'nacogdoches' => 'deep east texas',
    'delrio' => 'del rio / eagle pass',
    'delaware' => 'delaware',
    'denver' => 'denver',
    'desmoines' => 'des moines',
    'detroit' => 'detroit metro',
    'dothan' => 'dothan, AL',
    'dubuque' => 'dubuque',
    'duluth' => 'duluth / superior',
    'eastidaho' => 'east idaho',
    'eastoregon' => 'east oregon',
    'eastco' => 'eastern CO',
    'newlondon' => 'eastern CT',
    'eastnc' => 'eastern NC',
    'eastky' => 'eastern kentucky',
    'martinsburg' => 'eastern panhandle',
    'easternshore' => 'eastern shore',
    'eauclaire' => 'eau claire',
    'elpaso' => 'el paso',
    'elko' => 'elko',
    'elmira' => 'elmira-corning',
    'erie' => 'erie, PA',
    'eugene' => 'eugene',
    'evansville' => 'evansville',
    'fairbanks' => 'fairbanks',
    'fargo' => 'fargo / moorhead',
    'farmington' => 'farmington, NM',
    'fayetteville' => 'fayetteville',
    'fayar' => 'fayetteville, AR',
    'fingerlakes' => 'finger lakes',
    'flagstaff' => 'flagstaff / sedona',
    'flint' => 'flint',
    'shoals' => 'florence / muscle shoals',
    'florencesc' => 'florence, SC',
    'keys' => 'florida keys',
    'fortcollins' => 'fort collins / north CO',
    'fortdodge' => 'fort dodge',
    'fortsmith' => 'fort smith, AR',
    'fortwayne' => 'fort wayne',
    'frederick' => 'frederick',
    'fredericksburg' => 'fredericksburg',
    'fresno' => 'fresno / madera',
    'fortmyers' => 'ft myers / SW florida',
    'gadsden' => 'gadsden-anniston',
    'gainesville' => 'gainesville',
    'galveston' => 'galveston',
    'glensfalls' => 'glens falls',
    'goldcountry' => 'gold country',
    'grandforks' => 'grand forks',
    'grandisland' => 'grand island',
    'grandrapids' => 'grand rapids',
    'greatfalls' => 'great falls',
    'greenbay' => 'green bay',
    'greensboro' => 'greensboro',
    'greenville' => 'greenville / upstate',
    'gulfport' => 'gulfport / biloxi',
    'norfolk' => 'hampton roads',
    'hanford' => 'hanford-corcoran',
    'harrisburg' => 'harrisburg',
    'harrisonburg' => 'harrisonburg',
    'hartford' => 'hartford',
    'hattiesburg' => 'hattiesburg',
    'honolulu' => 'hawaii',
    'cfl' => 'heartland florida',
    'helena' => 'helena',
    'hickory' => 'hickory / lenoir',
    'rockies' => 'high rockies',
    'hiltonhead' => 'hilton head',
    'holland' => 'holland',
    'houma' => 'houma',
    'houston' => 'houston',
    'hudsonvalley' => 'hudson valley',
    'humboldt' => 'humboldt county',
    'huntington' => 'huntington-ashland',
    'huntsville' => 'huntsville / decatur',
    'imperial' => 'imperial county',
    'indianapolis' => 'indianapolis',
    'inlandempire' => 'inland empire',
    'iowacity' => 'iowa city',
    'ithaca' => 'ithaca',
    'jxn' => 'jackson, MI',
    'jackson' => 'jackson, MS',
    'jacksontn' => 'jackson, TN',
    'jacksonville' => 'jacksonville',
    'onslow' => 'jacksonville, NC',
    'janesville' => 'janesville',
    'jerseyshore' => 'jersey shore',
    'jonesboro' => 'jonesboro',
    'joplin' => 'joplin',
    'kalamazoo' => 'kalamazoo',
    'kalispell' => 'kalispell',
    'kansascity' => 'kansas city, MO',
    'kenai' => 'kenai peninsula',
    'kpr' => 'kennewick-pasco-richland',
    'racine' => 'kenosha-racine',
    'killeen' => 'killeen / temple / ft hood',
    'kirksville' => 'kirksville',
    'klamath' => 'klamath falls',
    'knoxville' => 'knoxville',
    'kokomo' => 'kokomo',
    'lacrosse' => 'la crosse',
    'lasalle' => 'la salle co',
    'lafayette' => 'lafayette',
    'tippecanoe' => 'lafayette / west lafayette',
    'lakecharles' => 'lake charles',
    'loz' => 'lake of the ozarks',
    'lakeland' => 'lakeland',
    'lancaster' => 'lancaster, PA',
    'lansing' => 'lansing',
    'laredo' => 'laredo',
    'lascruces' => 'las cruces',
    'lasvegas' => 'las vegas',
    'lawrence' => 'lawrence',
    'lawton' => 'lawton',
    'allentown' => 'lehigh valley',
    'lewiston' => 'lewiston / clarkston',
    'lexington' => 'lexington, KY',
    'limaohio' => 'lima / findlay',
    'lincoln' => 'lincoln',
    'littlerock' => 'little rock',
    'logan' => 'logan',
    'longisland' => 'long island',
    'losangeles' => 'los angeles',
    'louisville' => 'louisville',
    'lubbock' => 'lubbock',
    'lynchburg' => 'lynchburg',
    'macon' => 'macon / warner robins',
    'madison' => 'madison',
    'maine' => 'maine',
    'ksu' => 'manhattan, KS',
    'mankato' => 'mankato',
    'mansfield' => 'mansfield',
    'masoncity' => 'mason city',
    'mattoon' => 'mattoon-charleston',
    'mcallen' => 'mcallen / edinburg',
    'meadville' => 'meadville',
    'medford' => 'medford-ashland',
    'memphis' => 'memphis, TN',
    'mendocino' => 'mendocino county',
    'merced' => 'merced',
    'meridian' => 'meridian',
    'milwaukee' => 'milwaukee',
    'minneapolis' => 'minneapolis / st paul',
    'missoula' => 'missoula',
    'mobile' => 'mobile',
    'modesto' => 'modesto',
    'mohave' => 'mohave county',
    'monroemi' => 'monroe',
    'monroe' => 'monroe, LA',
    'montana' => 'montana (old)',
    'monterey' => 'monterey bay',
    'montgomery' => 'montgomery',
    'morgantown' => 'morgantown',
    'moseslake' => 'moses lake',
    'muncie' => 'muncie / anderson',
    'muskegon' => 'muskegon',
    'myrtlebeach' => 'myrtle beach',
    'nashville' => 'nashville',
    'nh' => 'new hampshire',
    'newhaven' => 'new haven',
    'neworleans' => 'new orleans',
    'blacksburg' => 'new river valley',
    'newyork' => 'new york city',
    'lakecity' => 'north central FL',
    'nd' => 'north dakota',
    'newjersey' => 'north jersey',
    'northmiss' => 'north mississippi',
    'northplatte' => 'north platte',
    'nesd' => 'northeast SD',
    'northernwi' => 'northern WI',
    'nmi' => 'northern michigan',
    'wheeling' => 'northern panhandle',
    'nwct' => 'northwest CT',
    'nwga' => 'northwest GA',
    'nwks' => 'northwest KS',
    'enid' => 'northwest OK',
    'ocala' => 'ocala',
    'odessa' => 'odessa / midland',
    'ogden' => 'ogden-clearfield',
    'okaloosa' => 'okaloosa / walton',
    'oklahomacity' => 'oklahoma city',
    'olympic' => 'olympic peninsula',
    'omaha' => 'omaha / council bluffs',
    'oneonta' => 'oneonta',
    'orangecounty' => 'orange county',
    'oregoncoast' => 'oregon coast',
    'orlando' => 'orlando',
    'outerbanks' => 'outer banks',
    'owensboro' => 'owensboro',
    'palmsprings' => 'palm springs, CA',
    'panamacity' => 'panama city, FL',
    'parkersburg' => 'parkersburg-marietta',
    'pensacola' => 'pensacola',
    'peoria' => 'peoria',
    'philadelphia' => 'philadelphia',
    'phoenix' => 'phoenix',
    'csd' => 'pierre / central SD',
    'pittsburgh' => 'pittsburgh',
    'plattsburgh' => 'plattsburgh-adirondacks',
    'poconos' => 'poconos',
    'porthuron' => 'port huron',
    'portland' => 'portland, OR',
    'potsdam' => 'potsdam-canton-massena',
    'prescott' => 'prescott',
    'provo' => 'provo / orem',
    'pueblo' => 'pueblo',
    'pullman' => 'pullman / moscow',
    'quadcities' => 'quad cities, IA/IL',
    'raleigh' => 'raleigh / durham / CH',
    'rapidcity' => 'rapid city / west SD',
    'reading' => 'reading',
    'redding' => 'redding',
    'reno' => 'reno / tahoe',
    'providence' => 'rhode island',
    'richmond' => 'richmond',
    'richmondin' => 'richmond, IN',
    'roanoke' => 'roanoke',
    'rmn' => 'rochester, MN',
    'rochester' => 'rochester, NY',
    'rockford' => 'rockford',
    'roseburg' => 'roseburg',
    'roswell' => 'roswell / carlsbad',
    'sacramento' => 'sacramento',
    'saginaw' => 'saginaw-midland-baycity',
    'salem' => 'salem, OR',
    'salina' => 'salina',
    'saltlakecity' => 'salt lake city',
    'sanangelo' => 'san angelo',
    'sanantonio' => 'san antonio',
    'sandiego' => 'san diego',
    'slo' => 'san luis obispo',
    'sanmarcos' => 'san marcos',
    'sandusky' => 'sandusky',
    'santabarbara' => 'santa barbara',
    'santafe' => 'santa fe / taos',
    'santamaria' => 'santa maria',
    'sarasota' => 'sarasota-bradenton',
    'savannah' => 'savannah / hinesville',
    'scottsbluff' => 'scottsbluff / panhandle',
    'scranton' => 'scranton / wilkes-barre',
    'seattle' => 'seattle-tacoma',
    'sheboygan' => 'sheboygan, WI',
    'showlow' => 'show low',
    'shreveport' => 'shreveport',
    'sierravista' => 'sierra vista',
    'siouxcity' => 'sioux city, IA',
    'siouxfalls' => 'sioux falls / SE SD',
    'siskiyou' => 'siskiyou county',
    'skagit' => 'skagit / island / SJI',
    'southbend' => 'south bend / michiana',
    'southcoast' => 'south coast',
    'sd' => 'south dakota',
    'miami' => 'south florida',
    'southjersey' => 'south jersey',
    'ottumwa' => 'southeast IA',
    'seks' => 'southeast KS',
    'juneau' => 'southeast alaska',
    'semo' => 'southeast missouri',
    'swv' => 'southern WV',
    'carbondale' => 'southern illinois',
    'smd' => 'southern maryland',
    'swks' => 'southwest KS',
    'marshall' => 'southwest MN',
    'natchez' => 'southwest MS',
    'bigbend' => 'southwest TX',
    'swva' => 'southwest VA',
    'swmi' => 'southwest michigan',
    'spacecoast' => 'space coast',
    'spokane' => "spokane / coeur d'alene",
    'springfieldil' => 'springfield, IL',
    'springfield' => 'springfield, MO',
    'staugustine' => 'st augustine',
    'stcloud' => 'st cloud',
    'stgeorge' => 'st george',
    'stjoseph' => 'st joseph',
    'stlouis' => 'st louis, MO',
    'pennstate' => 'state college',
    'statesboro' => 'statesboro',
    'stillwater' => 'stillwater',
    'stockton' => 'stockton',
    'susanville' => 'susanville',
    'syracuse' => 'syracuse',
    'tallahassee' => 'tallahassee',
    'tampa' => 'tampa bay area',
    'terrehaute' => 'terre haute',
    'texarkana' => 'texarkana',
    'texoma' => 'texoma',
    'thumb' => 'the thumb',
    'toledo' => 'toledo',
    'topeka' => 'topeka',
    'treasure' => 'treasure coast',
    'tricities' => 'tri-cities, TN',
    'tucson' => 'tucson',
    'tulsa' => 'tulsa',
    'tuscaloosa' => 'tuscaloosa',
    'tuscarawas' => 'tuscarawas co',
    'twinfalls' => 'twin falls',
    'twintiers' => 'twin tiers NY/PA',
    'easttexas' => 'tyler / east TX',
    'up' => 'upper peninsula',
    'utica' => 'utica-rome-oneida',
    'valdosta' => 'valdosta',
    'ventura' => 'ventura county',
    'burlington' => 'vermont',
    'victoriatx' => 'victoria, TX',
    'visalia' => 'visalia-tulare',
    'waco' => 'waco',
    'washingtondc' => 'washington, DC',
    'waterloo' => 'waterloo / cedar falls',
    'watertown' => 'watertown',
    'wausau' => 'wausau',
    'wenatchee' => 'wenatchee',
    'wv' => 'west virginia (old)',
    'quincy' => 'western IL',
    'westky' => 'western KY',
    'westmd' => 'western maryland',
    'westernmass' => 'western massachusetts',
    'westslope' => 'western slope',
    'wichita' => 'wichita',
    'wichitafalls' => 'wichita falls',
    'williamsport' => 'williamsport',
    'wilmington' => 'wilmington, NC',
    'winchester' => 'winchester',
    'winstonsalem' => 'winston-salem',
    'worcester' => 'worcester / central MA',
    'wyoming' => 'wyoming',
    'yakima' => 'yakima',
    'york' => 'york, PA',
    'youngstown' => 'youngstown',
    'yubasutter' => 'yuba-sutter',
    'yuma' => 'yuma',
    'zanesville' => 'zanesville / cambridge'
  }
  
  CATEGORIES = { 'atq' => 'antiques',
    'app' => 'appliances',
    'art' => 'arts & crafts',
    'pts' => 'auto parts',
    'bab' => 'baby & kid stuff',
    'bar' => 'barter',
    'bik' => 'bicycles',
    'boa' => 'boats',
    'bks' => 'books',
    'bfs' => 'business',
    'ctd' => 'cars & trucks - by dealer',
    'cto' => 'cars & trucks - by owner',
    'cta' => 'cars & trucks',
    'emd' => 'cds / dvds / vhs',
    'mob' => 'cell phones',
    'clo' => 'clothing',
    'clt' => 'collectibles',
    'sys' => 'computers & tech',
    'ele' => 'electronics',
    'grd' => 'farm & garden',
    'zip' => 'free stuff',
    'fua' => 'furniture',
    'fud' => 'furniture - by dealer',
    'fuo' => 'furniture - by owner',
    'gms' => 'garage sales',
    'for' => 'general',
    'hab' => 'health and beauty',
    'hsh' => 'household',
    'wan' => 'items wanted',
    'jwl' => 'jewelry',
    'mat' => 'materials',
    'mca' => 'motorcycles',
    'mcd' => 'motorcycles/scooters - by dealer',
    'mcy' => 'motorcycles/scooters - by owner',
    'msg' => 'musical instruments',
    'pho' => 'photo/video',
    'rvs' => 'recreational vehicles',
    'spo' => 'sporting goods',
    'tia' => 'tickets',
    'tid' => 'tickets - by dealer',
    'tix' => 'tickets - by owner',
    'tls' => 'tools',
    'tag' => 'toys & games',
    'vgm' => 'video gaming' 
  }
  

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
    # if scope.blank?
    #   tScope = "A"
    # else
    #   tScope = scope
    # end
    # if keywords.empty?
    #   tKeywords = ""
    # else
    #   tKeywords = keywords.map(&:value).join("+")
    # end
    # if filters.empty?
    #   tFilters = ""
    # else
    #   tFilters = filters.collect {|f| "#{f.key}=#{f.value}"}.join("&") + "&"
    # end
    # 
    # if tKeywords == "" && tFilters == ""
    #   # handle case where no keywords or filters are present
    #   url = "http://#{region}.craigslist.org/#{category}/index.rss"
    # else      
    #   url = "http://#{region}.craigslist.org/search/#{category}?query=#{tKeywords}&srchType=#{tScope}&#{tFilters}format=rss".gsub(/ /,"+")
    # end
    # puts "Fetching #{url}"
    # rss = Feedzirra::Feed.fetch_and_parse(url)
    # if rss
    #   cutoff_date = last_item_published_at
    #   new_entries = rss.entries.select {|e| e.published > cutoff_date}
    #   puts "Found #{rss.entries.size} entries (#{new_entries.size} new)"
    #   housing_regex = /(.+) \$(\d+) ?(.*)/
    #   location_price_regex = /(.+) \((.+)\) ?\$?(\d+)?/
    #   location_regex = /(.+) \((.+)\)/
    #   items = new_entries.map do |e| 
    #     if temporary
    #       if e.title =~ location_price_regex
    #         Item.new(:title => e.title.match(location_price_regex)[1], :price => e.title.match(location_price_regex)[3], :location => e.title.match(location_price_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
    #       elsif e.title =~ location_regex
    #         Item.new(:title => e.title.match(location_regex)[1], :location => e.title.match(location_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
    #       elsif e.title =~ housing_regex
    #           Item.new(:title => e.title.match(housing_regex)[1], :price => e.title.match(housing_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
    #       else
    #         Item.new(:title => e.title, :summary => e.summary, :link => e.url, :published_at => e.published)
    #       end
    #     else
    #       if e.title =~ location_price_regex
    #         Item.create(:feed_id => id, :title => e.title.match(location_price_regex)[1], :price => e.title.match(location_price_regex)[3], :location => e.title.match(location_price_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
    #       elsif e.title =~ location_regex
    #         Item.create(:feed_id => id, :title => e.title.match(location_regex)[1], :location => e.title.match(location_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
    #       elsif e.title =~ housing_regex
    #           Item.create(:feed_id => id, :title => e.title.match(housing_regex)[1], :price => e.title.match(housing_regex)[2], :summary => e.summary, :link => e.url, :published_at => e.published)
    #       else
    #         Item.create(:feed_id => id, :title => e.title, :summary => e.summary, :link => e.url, :published_at => e.published)
    #       end
    #     end
    #   end
    # else
    #   puts "Unable to parse feed"
    #   items = []
    # end
    # items
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
      filters = feed[:filters].keys.collect {|f| "#{f}=#{feed[:filters][f.to_sym]}"}.join("&") + "&"
    else
      filters = ""
    end
    
    puts "region: #{feed[:region]}\tcategory: #{feed[:category]}\tscope: #{scope}\tkeywords: #{keywords}\tfilters: #{filters}"
    if keywords == "" && filters == ""
      # handle case where no keywords or filters are sent
      url = "http://#{feed[:region]}.craigslist.org/#{feed[:category]}/index.rss"
    elsif start!=0
      # client requested a start index, so send it to CL
      url = "http://#{feed[:region]}.craigslist.org/search/#{feed[:category]}?query=#{keywords}&srchType=#{scope}&#{filters}s=#{start}&format=rss".gsub(/ /,"+")
    else      
      # no start index given, so don't send one to CL
      url = "http://#{feed[:region]}.craigslist.org/search/#{feed[:category]}?query=#{keywords}&srchType=#{scope}&#{filters}format=rss".gsub(/ /,"+")
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
