Sham.category_name(:unique => false) do |i|
  names = ['best sound', 'best director', 'best actor']
  names[i % names.size]
end

Category.blueprint do
  name { Sham.category_name }
  points { 1 }
  year { Date.today.year }
end

Category.blueprint(:best_picture) do
  name { 'best picture' }
  points { 5 }
end
