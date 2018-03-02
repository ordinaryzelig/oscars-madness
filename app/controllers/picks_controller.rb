class PicksController < ApplicationController

  before_action :authenticate

  # Load
  before_action :entry
  before_action :categories

  # More authentication
  before_action :authenticate_rights_to_write

  helper_method :entry, :categories

  def edit
    @edit_mode = true
  end

  def update
    entry.picks_attributes = params[:picks]
    entry.save!
    redirect_to root_path
  end

  private

  def entry
    @entry ||=
      logged_in_player
        .entries
        .includes(:picks)
        .find_by_year(Contest.years.last)
  end

  def categories
    @categories ||=
      Category
        .includes({:nominees => :film})
        .for_year(Contest.years.last)
  end

  def authenticate_rights_to_write
    if picks_editable? && Contest.latest?(contest_year)
      true
    else
      redirect_to root_path
      false
    end
  end

end
