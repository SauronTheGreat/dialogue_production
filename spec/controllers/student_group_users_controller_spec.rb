require File.dirname(__FILE__) + '/../spec_helper'

describe StudentGroupUsersController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => StudentGroupUser.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    StudentGroupUser.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    StudentGroupUser.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(student_group_user_url(assigns[:student_group_user]))
  end

  it "edit action should render edit template" do
    get :edit, :id => StudentGroupUser.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    StudentGroupUser.any_instance.stubs(:valid?).returns(false)
    put :update, :id => StudentGroupUser.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    StudentGroupUser.any_instance.stubs(:valid?).returns(true)
    put :update, :id => StudentGroupUser.first
    response.should redirect_to(student_group_user_url(assigns[:student_group_user]))
  end

  it "destroy action should destroy model and redirect to index action" do
    student_group_user = StudentGroupUser.first
    delete :destroy, :id => student_group_user
    response.should redirect_to(student_group_users_url)
    StudentGroupUser.exists?(student_group_user.id).should be_false
  end
end
