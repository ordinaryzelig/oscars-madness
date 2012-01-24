class CategoriesController < AdminController

  skip_before_filter :authenticate_admin, :only => :show
  before_filter :load_contest_year

  def index
    if params[:term]
      @categories = Category.for_year(Contest.years.last).search(params[:term])
      render :text => @categories.map(&:name).to_json
    else
      @categories = Category.for_year(contest_year).all(:include => :nominees, :order => :created_at)
    end
  end

  def show
    @category = Category.find(params[:id], :include => [:nominees => {:picks => [{:entry => :player}, :nominee]}])
    @picks = @category.picks
  end

  def new
    @category = Category.new
  end

  def create
    Category.create!(params[:category])
    redirect_to new_category_path
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes! params[:category]
    redirect_to categories_path
  end

end
