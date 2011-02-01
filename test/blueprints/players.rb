Sham.player_name(:unique => false) { ['jared', 'stephanie', 'ryan', 'amy'].sample }

Player.blueprint do
  name { Sham.player_name }
  password { 'asdf' }
end
