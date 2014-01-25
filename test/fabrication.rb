Fabricator(:admin_config) do
  picks_editable true
  admin_password 'fdsa'.digest
end

Fabricator(:category) do
  name   'best director'
  points 1
  year   Date.today.year
end

Fabricator(:best_picture, from: :category) do
  name   'best picture'
  points 5
end

Fabricator(:entry) do
  player
  year Date.today.year
end

Fabricator(:film) do
  name 'Up'
end

Fabricator(:nominee) do
  category
  film
  name { |atts| "#{atts[:film].name} for #{atts[:category].name}" }
end

Fabricator(:pick) do
  category
  entry
  nominee
end

Fabricate.sequence(:player_name) { |idx| "player #{idx}" }

Fabricator(:player) do
  name     { Fabricate.sequence(:player_name) }
  password 'asdf'
end
