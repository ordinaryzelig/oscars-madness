Sham.category_name { ['best sound', 'best director', 'best actor'].rand }

Category.blueprint do
  name { Sham.category_name }
  points { 1 }
end

Category.blueprint(:best_picture) do
  name { 'best picture' }
end
