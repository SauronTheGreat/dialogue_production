require File.dirname(__FILE__) + '/../spec_helper'

describe MetricsController do
  fixtures :all
  integrate_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Metric.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Metric.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Metric.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(metric_url(assigns[:metric]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Metric.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Metric.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Metric.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Metric.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Metric.first
    response.should redirect_to(metric_url(assigns[:metric]))
  end

  it "destroy action should destroy model and redirect to index action" do
    metric = Metric.first
    delete :destroy, :id => metric
    response.should redirect_to(metrics_url)
    Metric.exists?(metric.id).should be_false
  end
end
