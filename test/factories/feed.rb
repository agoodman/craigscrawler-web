Factory.define :feed do |feed|
  feed.region   { Feed::REGIONS.keys[0] }
  feed.category { Feed::CATEGORIES.keys[0] }
end
