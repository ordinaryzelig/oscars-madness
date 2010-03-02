Sham.category_name { ['best picture', 'best director', 'best actor'].rand }

Category.blueprint do
  name { Sham.category_name }
  points { 1 }
end
