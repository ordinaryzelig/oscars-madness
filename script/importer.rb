module OscarsMadness

  module_function

  CATEGORY_OPTIONS = {
    "Best Picture"                  => {:points => 5, :flip => false},
    "Actor in a Leading Role"       => {:points => 3, :flip => true},
    "Actress in a Leading Role"     => {:points => 3, :flip => true},
    "Actor in a Supporting Role"    => {:points => 2, :flip => true},
    "Actress in a Supporting Role"  => {:points => 2, :flip => true},
    "Animated Feature Film"         => {:points => 3, :flip => false},
    "Cinematography"                => {:points => 2, :flip => false},
    "Costume Design"                => {:points => 1, :flip => false},
    "Directing"                     => {:points => 3, :flip => false},
    "Documentary (Feature)"         => {:points => 3, :flip => false},
    "Documentary (Short Subject)"   => {:points => 2, :flip => false},
    "Film Editing"                  => {:points => 2, :flip => false},
    "Foreign Language Film"         => {:points => 3, :flip => false},
    "Makeup and Hairstyling"        => {:points => 1, :flip => false},
    "Music (Original Score)"        => {:points => 2, :flip => false},
    "Music (Original Song)"         => {:points => 1, :flip => false},
    "Production Design"             => {:points => 2, :flip => false},
    "Short Film (Animated)"         => {:points => 1, :flip => false},
    "Short Film (Live Action)"      => {:points => 1, :flip => false},
    "Sound Editing"                 => {:points => 1, :flip => false},
    "Sound Mixing"                  => {:points => 1, :flip => false},
    "Visual Effects"                => {:points => 2, :flip => false},
    "Writing (Adapted Screenplay)"  => {:points => 2, :flip => false},
    "Writing (Original Screenplay)" => {:points => 3, :flip => false},
  }

  def import(json)
    categories = JSON.parse(json)
    categories.each do |category_json|
      name = category_json.fetch('category')
      options = CATEGORY_OPTIONS.fetch(name)
      category = Category.new({
        :name    => name,
        :year    => Date.today.year,
        :points  => options.fetch(:points),
        :flipped => options.fetch(:flip),
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
