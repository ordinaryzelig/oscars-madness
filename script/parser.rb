require 'bundler/setup'
require 'json'
require 'ap'

json = File.read("./nominations/#{Date.today.year}/source.json")
parsed = JSON.parse(json)

category_swaps = %w[
  actor-in-a-leading-role
  actor-in-a-supporting-role
  actress-in-a-leading-role
  actress-in-a-supporting-role
]

categories =
  parsed.dig('data', 'sections', 'nominees').map do |nom_key, noms_hash|
    category = {}
    category['category'] = noms_hash.fetch('category_name')
    category['nominees'] = []

    noms_hash['result'].each do |nom_hash|
      nominee, film = [
        nom_hash.dig(*%[nominee_description]),
        nom_hash.dig(*%[post_title]),
      ].tap { |h| h.reverse! if category_swaps.include?(nom_key) }
      category['nominees'] << {
        'nominee' => nominee,
        'film'    => film,
      }
    end
    category
  end

json = JSON.pretty_generate(categories)
File.open("./nominations/#{Date.today.year}/nominations.json", 'w') { |f| f.write json }
