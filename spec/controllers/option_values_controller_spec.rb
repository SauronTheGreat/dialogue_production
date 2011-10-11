require File.dirname(__FILE__) + '/../spec_helper'

describe OptionValuesController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => OptionValue.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    OptionValue.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    OptionValue.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(option_value_url(assigns[:option_value]))
  end

  it "edit action should render edit template" do
    get :edit, :id => OptionValue.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    OptionValue.any_instance.stubs(:valid?).returns(false)
    put :update, :id => OptionValue.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    OptionValue.any_instance.stubs(:valid?).returns(true)
    put :update, :id => OptionValue.first
    response.should redirect_to(option_value_url(assigns[:option_value]))
  end

  it "destroy action should destroy model and redirect to index action" do
    option_value = OptionValue.first
    delete :destroy, :id => option_value
    response.should redirect_to(option_values_url)
    OptionValue.exists?(option_value.id).should be_false
  end
end
