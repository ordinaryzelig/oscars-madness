class CategoriesController < ApplicationController

  before_filter :load_contest_year

  def show
    @category = Category.find(params[:id], :include => [:nominees => {:picks => [{:entry => :player}, :nominee]}])
    @picks = @category.picks
  end

end
