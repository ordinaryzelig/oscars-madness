require 'test_helper'

class NomineesControllerTest < ActionController::TestCase
  
  def setup
    super
    login_as_admin
  end
  
  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    category = Category.make
    film = Film.make
    name = 'asdf'
    post :create, :nominee => {:name => name, :film_id => film.id, :category_id => category.id}
    assert_equal name, Nominee.first.name
    assert_equal film, Nominee.first.film
    assert_equal category, Nominee.first.category
  end
  
  def test_edit
    nominee = Nominee.make
    get :edit, :id => nominee
    assert_response :success
  end
  
  def test_update
    nominee = Nominee.make
    new_name = nominee.name.reverse
    put :update, :id => nominee, :nominee => {:name => new_name}
    assert_equal new_name, Nominee.find(nominee).name
  end
  
end
