class RolesController < ApplicationController
  def index
    @roles = Role.all(:conditions=>['case_study_id=?',params[:case_study]])
    @case_study = CaseStudy.find(params[:case_study])
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
    @case_study = CaseStudy.find(params[:case_study])
  end

  def create
    @role = Role.new(params[:role])
	@case_study_id=params[:role][:case_study_id]

    if @role.save
      flash[:notice] = "Successfully created role."
      redirect_to :action=>'index',:case_study=>@case_study_id
    else
      redirect_to :action => 'new',:case_study=>@case_study_id
	  flash[:alert]="Name can't be blank"

    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      flash[:notice] = "Successfully updated role."
      redirect_to @role
    else
      render :action => 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @case_study=CaseStudy.find(@role.case_study_id)
    @role.destroy
    flash[:notice] = "Successfully destroyed role."
    redirect_to :action=>'index',:case_study=>@case_study.id
  end

end
