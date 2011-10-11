require File.dirname(__FILE__) + '/../spec_helper'

describe OffersController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Offer.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Offer.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Offer.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(offer_url(assigns[:offer]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Offer.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Offer.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Offer.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Offer.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Offer.first
    response.should redirect_to(offer_url(assigns[:offer]))
  end

  it "destroy action should destroy model and redirect to index action" do
    offer = Offer.first
    delete :destroy, :id => offer
    response.should redirect_to(offers_url)
    Offer.exists?(offer.id).should be_false
  end
end
