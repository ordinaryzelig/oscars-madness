module PlayersHelper

  def player_label(player, color = nil)
    content_tag :div, class: "player ui label image #{color}" do
      image_tag = image_tag(player.facebook_image_url)
      image_tag + player.name
    end
  end

end
