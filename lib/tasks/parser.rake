task :parse => :environment do
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
        flip = category_swaps.include?(nom_key)
        nominee, film = [
          nom_hash.dig(*%[nominee_description]),
          nom_hash.dig(*%[post_title]),
        ].tap { |h| h.reverse! if flip }
        category['nominees'] << {
          'nominee' => nominee,
          'film'    => film,
        }
      end
      category
    end

  json = JSON.pretty_generate(categories)
  filename = "./nominations/#{Date.today.year}/nominations.json"
  ap filename
  ap File.open(filename, 'w') { |f| f.write json }
end
