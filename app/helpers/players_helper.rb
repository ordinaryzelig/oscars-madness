module PlayersHelper

  def player_label(player, color = nil)
    content_tag :div, class: "player ui label image #{color}" do
      image_tag = image_tag(player.facebook_image_url)
      name = mobile? ? short_name(player.name) : player.name
      image_tag + name
    end
  end

  def short_name(name)
    first, *middle, last = name.split(' ')
    last_initial = initial = last[0] and initial << '.' if last
    first
    #[first, last_initial].compact.join(' ')
  end

end
