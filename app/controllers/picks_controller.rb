class PicksController < ApplicationController

  before_filter :authenticate

  # Load
  before_filter :entry
  before_filter :categories

  # More authentication
  before_filter :authenticate_rights_to_write

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
    @entry ||= logged_in_player.entries.find_by_year(Contest.years.last, :include => :picks)
  end

  def categories
    @categories ||= Category.for_year(Contest.years.last).all(:include => {:nominees => :film})
  end

  def authenticate_rights_to_write
    unless picks_editable?
      redirect_to root_path
      return false
    end
    true
  end

end
