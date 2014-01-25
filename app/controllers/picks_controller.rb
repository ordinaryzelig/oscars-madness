class PicksController < ApplicationController

  before_filter :authenticate, :except => [:index]
  before_filter :load_player
  before_filter :load_entry
  before_filter :authenticate_rights_to_read, :only => [:index]
  before_filter :authenticate_rights_to_write, :only => [:edit, :update]
  before_filter :load_categories

  def index
  end

  def edit
  end

  def update
    @entry.picks_attributes = params[:picks]
    @entry.save!
    redirect_to player_picks_path(@player)
  end

  private

  def load_player
    @player = Player.find_by_id(params[:player_id]) if params[:player_id]
  end

  def load_entry
    @entry = @player.entries.find_by_year(Contest.years.last, :include => :picks) if @player
  end

  def load_categories
    @categories = Category.for_year(Contest.years.last).all(:include => {:nominees => :film})
  end

  def authenticate_rights_to_read
    return true if logged_in_player_looking_at_own_picks? || others_can_read?
    redirect_to root_path
    false
  end

  def authenticate_rights_to_write
    unless logged_in_player_looking_at_own_picks? && admin_config.picks_editable
      redirect_to root_path
      return false
    end
    true
  end

  def logged_in_player_looking_at_own_picks?
    logged_in_player == @player
  end

  def others_can_read?
    !admin_config.picks_editable
  end

end
