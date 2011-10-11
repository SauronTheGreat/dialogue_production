require File.dirname(__FILE__) + '/../spec_helper'

describe IssueOptionsController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => IssueOption.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    IssueOption.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    IssueOption.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(issue_option_url(assigns[:issue_option]))
  end

  it "edit action should render edit template" do
    get :edit, :id => IssueOption.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    IssueOption.any_instance.stubs(:valid?).returns(false)
    put :update, :id => IssueOption.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    IssueOption.any_instance.stubs(:valid?).returns(true)
    put :update, :id => IssueOption.first
    response.should redirect_to(issue_option_url(assigns[:issue_option]))
  end

  it "destroy action should destroy model and redirect to index action" do
    issue_option = IssueOption.first
    delete :destroy, :id => issue_option
    response.should redirect_to(issue_options_url)
    IssueOption.exists?(issue_option.id).should be_false
  end
end
