class StudentGroupMetricsController < ApplicationController
  def index
    @student_group_metrics = StudentGroupMetric.all
  end

  def show
    @student_group_metric = StudentGroupMetric.find(params[:id])
  end

  def new
    @student_group = StudentGroup.find(params[:student_group])
    @student_group_metrics = Array.new(Metric.all.count) { StudentGroupMetric.new }
  end

  def create
    @student_group_metrics = params[:student_group_metrics].values.collect { |student_group_metric| StudentGroupMetric.new(student_group_metric) }
    if @student_group_metrics.all?(&:valid?)
      @allmetrics=Metric.all.count
      @i=0
      @student_group_metrics.each do |sgr|
        @sg=sgr.student_group_id
        @i+=1
        if sgr.metric
          sgr.save! unless StudentGroupMetric.find(:first,:conditions=>["student_group_id=? and metric_id=?",sgr.student_group_id,sgr.metric_id])
        else
          @exsgr.destroy if @exsgr=StudentGroupMetric.find(:first,:conditions=>["student_group_id=? and metric_id=?",sgr.student_group_id,@i])
        end
      end
      redirect_to :controller=>'student_groups', :action => 'show', :id=> @sg
    else
      render :action => 'new'
    end
  end

  def edit
    @student_group_metric = StudentGroupMetric.find(params[:id])
  end

  def update
    @student_group_metric = StudentGroupMetric.find(params[:id])
    if @student_group_metric.update_attributes(params[:student_group_metric])
      flash[:notice] = "Successfully updated student group metric."
      redirect_to @student_group_metric
    else
      render :action => 'edit'
    end
  end

  def destroy
    @student_group_metric = StudentGroupMetric.find(params[:id])
    @student_group_metric.destroy
    flash[:notice] = "Successfully destroyed student group metric."
    redirect_to student_group_metrics_url
  end
end
