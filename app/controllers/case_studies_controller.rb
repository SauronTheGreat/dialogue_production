class CaseStudiesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    #@case_studies = CaseStudy.all(:order=>sort_column+" "+sort_direction)
    @case_studies=CaseStudy.find(:all,:conditions => ['case_study_type= ? or case_study_type = ?',0,current_user.id])
    render :layout => 'layouts/new_case_study'
  end

  def show
    @case_study = CaseStudy.find(params[:id])

  end

  def new
    @case_study = CaseStudy.new
  end

  def create
    @case_study = CaseStudy.new(params[:case_study])
    if @case_study.save
      flash[:notice] = "Successfully created case study."
      redirect_to case_study_path(@case_study,:check_form=>"true")
    else
      render :action => 'new'
	end


  end

  def edit
    @case_study = CaseStudy.find(params[:id])
  end

  def update
    @case_study = CaseStudy.find(params[:id])
    if @case_study.update_attributes(params[:case_study])
      flash[:notice] = "Successfully updated case study."
      redirect_to case_study_path(@case_study,:check_form=>"true")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @case_study = CaseStudy.find(params[:id])
    @case_study.destroy
    flash[:notice] = "Successfully destroyed case study."
    redirect_to case_studies_url
  end

  def sort_column
    CaseStudy.column_names.include?(params[:sort])? params[:sort]: "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction]: "asc"
  end

  def study_selection

  end

end
