json.array!(@rating) do |rating|
  json.extract! rating, :id, :score
end
