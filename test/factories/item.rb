Factory.define :item do |item|
  item.title  { "title" }
  item.link   { "http://host/path/to" }
  item.published_at { Time.now }
end
