require File.dirname(__FILE__) + '/../spec_helper'

describe GamesController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Game.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Game.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Game.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(game_url(assigns[:game]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Game.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Game.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Game.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Game.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Game.first
    response.should redirect_to(game_url(assigns[:game]))
  end

  it "destroy action should destroy model and redirect to index action" do
    game = Game.first
    delete :destroy, :id => game
    response.should redirect_to(games_url)
    Game.exists?(game.id).should be_false
  end
end
