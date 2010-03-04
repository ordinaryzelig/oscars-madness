class PlayersController < AdminController
  
  skip_before_filter :authenticate_admin, :only => [:edit, :update]
  before_filter :authenticate, :except => [:new, :create]
  before_filter :load_player, :only => [:edit, :update]
  before_filter :authenticate_rights_to_write, :only => [:edit, :update]
  
  def new
    @player = Player.new
  end
  
  def create
    @player = Player.new params[:player]
    if @player.save
      redirect_to player_edit_picks_path(@player)
    else
      render :action => 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    player_atts = params[:player].dup
    ['password', 'password_confirmation'].each do |att|
      player_atts.delete(att) if player_atts[att].blank?
    end
    if @player.update_attributes(player_atts)
      redirect_to player_edit_picks_path(@player)
    else
      render :action => :edit
    end
  end
  
  protected
  
  def load_player
    @player = Player.find_by_id(params[:id])
  end
  
  def authenticate_rights_to_write
    return true if logged_in_as_admin?
    is_own_profile = @player == logged_in_player
    redirect_to edit_player_path(logged_in_player) unless is_own_profile
  end
  
end
