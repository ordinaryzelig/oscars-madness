Sham.film_name(:unique => false) do |i|
  names = ['Avatar', 'Up', 'Precious']
  names[i % names.size]
end

Film.blueprint do
  name { Sham.film_name }
end
