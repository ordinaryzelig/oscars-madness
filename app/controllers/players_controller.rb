class PlayersController < AdminController
  
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
  
end
