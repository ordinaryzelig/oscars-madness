require 'bundler/setup'
require 'nokogiri'
require 'json'

html = File.read("./nominations/#{Date.today.year}/source.html")
doc = Nokogiri.HTML(html)

def log(*obj)
  puts obj.first if $DEBUG
end

def parse_category(listing)
  # category
  category =
    listing.
    at_css('.nomCatTitleWrapper').
    text.
    strip.
    gsub(/\s+/, ' ')
  log "**#{category.upcase}**"

  # nominees
  nominees = listing.css('.nomineesList li').map do |nom_node|
    title    = nom_node.at_css('.title').text
    subtitle = nom_node.at_css('.subtitle').text
    if category =~ /act/i && category !~ /action/i
      nominee = title
      film = subtitle
    else
      film = title
      nominee = subtitle
    end
    log nominee
    log film
    log

    {
      :nominee => nominee,
      :film    => film,
    }
  end

  {
    :category => category,
    :nominees => nominees,
  }
end

listings = []

single_listings = doc.css('.single-cat')
listings.push(*single_listings)

multiple_listings =
  doc.css('.nomineeRowContainer').
  reject { |node| node.attr('class').include?('single-cat') }
multiple_listings.each do |multi_listing|
  listings.push(*multi_listing.css('.contentArea'))
end

categories = listings.map do |listing|
  parse_category(listing)
end

json = JSON.pretty_generate(categories)
File.open("./nominations/#{Date.today.year}/nominations.json", 'w') { |f| f.write json }
