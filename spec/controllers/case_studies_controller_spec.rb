require File.dirname(__FILE__) + '/../spec_helper'

describe CaseStudiesController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => CaseStudy.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    CaseStudy.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    CaseStudy.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(case_study_url(assigns[:case_study]))
  end

  it "edit action should render edit template" do
    get :edit, :id => CaseStudy.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    CaseStudy.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CaseStudy.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    CaseStudy.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CaseStudy.first
    response.should redirect_to(case_study_url(assigns[:case_study]))
  end

  it "destroy action should destroy model and redirect to index action" do
    case_study = CaseStudy.first
    delete :destroy, :id => case_study
    response.should redirect_to(case_studies_url)
    CaseStudy.exists?(case_study.id).should be_false
  end
end
