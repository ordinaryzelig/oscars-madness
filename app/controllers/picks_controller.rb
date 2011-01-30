class PicksController < ApplicationController

  before_filter :authenticate, :except => [:index]
  before_filter :load_player
  before_filter :authenticate_rights_to_read, :only => [:index]
  before_filter :authenticate_rights_to_write, :only => [:edit, :update]
  before_filter :load_categories

  def index

  end

  def edit
    redirect_to root_path unless admin_config.picks_editable || logged_in_as_admin?
  end

  def update
    unless admin_config.picks_editable || logged_in_as_admin?
      redirect_to root_path
      return
    end
    @player.picks_attributes = params[:picks]
    @player.save!
    redirect_to player_picks_url(@player)
  end

  private

  def load_player
    @player = Player.find_by_id(params[:player_id], :include => :picks) if params[:player_id]
  end

  def load_categories
    @categories = Category.for_year(contest_year).all(:include => {:nominees => :film})
  end

  def authenticate_rights_to_read
    return true if logged_in_as_admin? || logged_in_player_looking_at_own_picks? || !admin_config.picks_editable
    redirect_to root_path
    false
  end

  def authenticate_rights_to_write
    return true if logged_in_as_admin?
    if !logged_in_player_looking_at_own_picks?
      redirect_to root_path
      return false
    end
    true
  end

  def logged_in_player_looking_at_own_picks?
    logged_in_player == @player
  end

end
