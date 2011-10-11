class MetricsController < ApplicationController
  def index
    @metrics = Metric.all
  end

  def show
    @metric = Metric.find(params[:id])
  end

  def new
    @student_group=StudentGroup.find(params[:student_group])
    @metric = Metric.new
  end

  def create
    @metric = Metric.new(params[:metric])
    @student_group=StudentGroup.find(params[:student_group])

    respond_to do |format|
      if @metric.save
        format.html { redirect_to new_student_group_metric_path(:student_group=>@student_group.id) }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def edit
    @metric = Metric.find(params[:id])
  end

  def update
    @metric = Metric.find(params[:id])
    if @metric.update_attributes(params[:metric])
      flash[:notice] = "Successfully updated metric."
      redirect_to @metric
    else
      render :action => 'edit'
    end
  end

  def destroy
    @metric = Metric.find(params[:id])
    @metric.destroy
    flash[:notice] = "Successfully destroyed metric."
    redirect_to metrics_url
  end
end
