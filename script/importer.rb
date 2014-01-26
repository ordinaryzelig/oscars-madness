module OscarsMadness

  module_function

  def import(json)
    categories = JSON.parse(json)
    categories.each do |category_json|
      category = Category.new({
        :name   => category_json.fetch('category'),
        :year   => Date.today.year,
        :points => 1,
      })
      category.save!

      category_json.fetch('nominees').each do |nominee_json|
        film_name = nominee_json.fetch('film')
        film = films.fetch(film_name) do
          # Create film and add to cache.
          film = Film.new(:name => film_name)
          film.save!
          films[film.name] = film
        end

        nominee = Nominee.new({
          :name => nominee_json.fetch('nominee'),
          :film => film,
        })

        category.nominees << nominee
      end
    end
  end

  # Preload films and cache.
  def films
    @films ||= Film.all.each_with_object({}) do |film, hash|
      hash[film.name] = film
    end
  end

end

# Load rails.
ENV["RAILS_ENV"] ||= "development"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

# Import.
Film.transaction do
  json = File.read("./nominations/#{Date.today.year}/nominations.json")
  OscarsMadness.import(json)
  #raise ActiveRecord::Rollback
end
