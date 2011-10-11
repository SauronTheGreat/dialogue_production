class IssuesController < ApplicationController
  def index
    @issues = Issue.all(:conditions=>['case_study_id=?',params[:case_study]],:order=>"weightage DESC")
    @roles = Role.all(:conditions=>['case_study_id=?',params[:case_study]])
    @case_study = CaseStudy.find(params[:case_study])
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
    @case_study = CaseStudy.find(params[:case_study])
  end

  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      flash[:notice] = "Successfully created issue."
      redirect_to issues_path(:case_study=>@issue.case_study_id)
	else
	  flash[:error]="Please add text in the Name field"
      redirect_to :action => 'new', :case_study=>@issue.case_study_id

    end
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update_attributes(params[:issue])
      flash[:notice] = "Successfully updated issue."
      redirect_to @issue
    else
      render :action => 'edit'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    flash[:notice] = "Successfully destroyed issue."
    redirect_to issues_path(:case_study=>@issue.case_study_id)
  end
end
