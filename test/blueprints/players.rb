Sham.player_name { ['jared', 'stephanie', 'ryan', 'amy'].rand }

Player.blueprint do
  name { Sham.player_name }
  password { 'asdf' }
end
