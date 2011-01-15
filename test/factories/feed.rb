Factory.define :feed do |feed|
  feed.region   { Feed::REGIONS[0] }
  feed.category { Feed::CATEGORIES[0] }
end
