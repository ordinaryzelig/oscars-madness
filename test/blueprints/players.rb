Sham.player_name { ['jared', 'stephanie', 'ryan', 'amy'].rand }

Player.blueprint do
  name { Sham.player_name }
  email { "#{name}@gmail.com" }
end
