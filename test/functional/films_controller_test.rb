require 'test_helper'

class FilmsControllerTest < ActionController::TestCase

  def setup
    super
    login_as_admin
    AdminConfig.make
  end

  def test_index
    Film.make
    get :index
    assert_response :success
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    name = 'asdf'
    post :create, :film => {:name => name}
    assert_equal name, Film.first.name
  end

  def test_edit
    film = Film.make
    get :edit, :id => film
    assert_response :success
  end

  def test_update
    film = Film.make
    new_name = film.name.reverse
    put :update, :id => film, :film => {:name => new_name}
    assert_equal new_name, Film.find(film).name
  end

end
