require File.dirname(__FILE__) + '/../spec_helper'

describe PlayerScoresController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => PlayerScore.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    PlayerScore.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    PlayerScore.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(player_score_url(assigns[:player_score]))
  end

  it "edit action should render edit template" do
    get :edit, :id => PlayerScore.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    PlayerScore.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PlayerScore.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    PlayerScore.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PlayerScore.first
    response.should redirect_to(player_score_url(assigns[:player_score]))
  end

  it "destroy action should destroy model and redirect to index action" do
    player_score = PlayerScore.first
    delete :destroy, :id => player_score
    response.should redirect_to(player_scores_url)
    PlayerScore.exists?(player_score.id).should be_false
  end
end
