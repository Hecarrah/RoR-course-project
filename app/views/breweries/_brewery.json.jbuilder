json.extract! brewery, :id, :name, :year
json.beercount do
  json.count brewery.beers.count
end
json.status do
  json.value brewery.active
end
