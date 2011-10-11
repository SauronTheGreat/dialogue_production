require File.dirname(__FILE__) + '/../spec_helper'

describe EducatorCaseStudiesController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => EducatorCaseStudy.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    EducatorCaseStudy.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    EducatorCaseStudy.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(educator_case_study_url(assigns[:educator_case_study]))
  end

  it "edit action should render edit template" do
    get :edit, :id => EducatorCaseStudy.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    EducatorCaseStudy.any_instance.stubs(:valid?).returns(false)
    put :update, :id => EducatorCaseStudy.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    EducatorCaseStudy.any_instance.stubs(:valid?).returns(true)
    put :update, :id => EducatorCaseStudy.first
    response.should redirect_to(educator_case_study_url(assigns[:educator_case_study]))
  end

  it "destroy action should destroy model and redirect to index action" do
    educator_case_study = EducatorCaseStudy.first
    delete :destroy, :id => educator_case_study
    response.should redirect_to(educator_case_studies_url)
    EducatorCaseStudy.exists?(educator_case_study.id).should be_false
  end
end
