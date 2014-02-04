module NomineesHelper

  def winner_label(nominee)
    content_tag :div, 'Winner', class: 'ui label ribbon green'
  end

  def names_header(nominee)
    content_tag :div, class: 'info ui header big' do
      (nominee.major_name + minor_sub_header(nominee)).html_safe
    end
  end

  def pick_radio_button(entry, nominee)
    pick = entry.pick_for_category(nominee.category)
    name = pick_input_name(pick, nominee)
    checked = picked_nominee?(entry, nominee)
    value = nominee.id
    radio_button_tag name, value, checked
  end

  def pick_input_label(entry, nominee, &block)
    pick = entry.pick_for_category(nominee.category)
    name = pick_input_name(pick, nominee) + "_#{nominee.id}"
    content = capture(&block)
    label_tag name, content
  end

  def picks_to_show(all_picks, contest_year)
    return all_picks if previous_contest_year?(contest_year)

    # Current year and...
    if picks_editable?
      if logged_in_player
        logged_in_player_pick = all_picks.detect do |pick|
          pick.entry.player_id == logged_in_player.id
        end
        [logged_in_player_pick].compact
      else
        []
      end
    else
      # Oscars have started
      all_picks
    end
  end

private

  def minor_sub_header(nominee)
    content_tag :div, nominee.minor_name, class: 'sub header'
  end

  def picked_nominee?(entry, nominee)
    pick = entry.pick_for_category(nominee.category)
    pick.nominee_id == nominee.id
  end

  def pick_input_name(pick, nominee)
    "picks[#{pick.id}][nominee_id]"
  end

end
