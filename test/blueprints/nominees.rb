Nominee.blueprint do
  category { Category.make }
  film { Film.make }
  name { "#{film.name} for #{category.name}" }
end
