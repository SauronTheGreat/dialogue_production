require File.dirname(__FILE__) + '/../spec_helper'

describe StudentGroupMetricsController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => StudentGroupMetric.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    StudentGroupMetric.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    StudentGroupMetric.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(student_group_metric_url(assigns[:student_group_metric]))
  end

  it "edit action should render edit template" do
    get :edit, :id => StudentGroupMetric.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    StudentGroupMetric.any_instance.stubs(:valid?).returns(false)
    put :update, :id => StudentGroupMetric.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    StudentGroupMetric.any_instance.stubs(:valid?).returns(true)
    put :update, :id => StudentGroupMetric.first
    response.should redirect_to(student_group_metric_url(assigns[:student_group_metric]))
  end

  it "destroy action should destroy model and redirect to index action" do
    student_group_metric = StudentGroupMetric.first
    delete :destroy, :id => student_group_metric
    response.should redirect_to(student_group_metrics_url)
    StudentGroupMetric.exists?(student_group_metric.id).should be_false
  end
end
