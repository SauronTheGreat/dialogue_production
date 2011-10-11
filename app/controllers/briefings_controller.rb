class BriefingsController < ApplicationController

  def show
    @briefing = Briefing.find(params[:id])
  end

  def new
    @briefing = Briefing.new
    @role = Role.find(params[:role])
  end

  def create
    if @existing_briefing=Briefing.first(:conditions=>['role_id=?', Role.find(params[:briefing][:role_id]).id])
      @existing_briefing.destroy
    end

    @briefing = Briefing.new(params[:briefing])
    if @briefing.save
      flash[:notice] = "Successfully created briefing."
      redirect_to roles_path(:case_study=>@briefing.role.case_study.id,:check_form=>"true")
    else
      render :action => 'new'
    end
  end

  def destroy
    @briefing = Briefing.find(params[:id])
    @briefing.destroy
    flash[:notice] = "Successfully destroyed briefing."
    redirect_to briefings_url
  end
end
