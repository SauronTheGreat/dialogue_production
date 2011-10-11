require File.dirname(__FILE__) + '/../spec_helper'

describe PlayerScorecardsController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => PlayerScorecard.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    PlayerScorecard.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    PlayerScorecard.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(player_scorecard_url(assigns[:player_scorecard]))
  end

  it "edit action should render edit template" do
    get :edit, :id => PlayerScorecard.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    PlayerScorecard.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PlayerScorecard.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    PlayerScorecard.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PlayerScorecard.first
    response.should redirect_to(player_scorecard_url(assigns[:player_scorecard]))
  end

  it "destroy action should destroy model and redirect to index action" do
    player_scorecard = PlayerScorecard.first
    delete :destroy, :id => player_scorecard
    response.should redirect_to(player_scorecards_url)
    PlayerScorecard.exists?(player_scorecard.id).should be_false
  end
end
