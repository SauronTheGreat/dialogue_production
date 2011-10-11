class IssueOptionsController < ApplicationController
  def index
    @issue=Issue.find(params[:active_issue])
    @issue_options = IssueOption.all(:conditions=>['issue_id=?',@issue.id])
  end

  def show
    @issue_option = IssueOption.find(params[:id])
  end

  def new
    @issue=Issue.find(params[:active_issue])
    @issue_options = IssueOption.all(:conditions=>['issue_id=?',@issue.id])
    @issue_option = IssueOption.new
  end

  def create
    @issue_option = IssueOption.new(params[:issue_option])
    if @issue_option.save
      flash[:notice] = "Successfully created issue option."
      redirect_to new_issue_option_path(:active_issue=>@issue_option.issue_id)
    else
      render :action => 'new'
    end
  end

  def edit
    @issue=Issue.find(params[:active_issue])
    @issue_options = IssueOption.all(:conditions=>['issue_id=?',@issue.id])
    @issue_option = IssueOption.find(params[:id])
  end

  def update
    @issue_option = IssueOption.find(params[:id])
    if @issue_option.update_attributes(params[:issue_option])
      flash[:notice] = "Successfully updated issue option."
      redirect_to new_issue_option_path(:active_issue=>@issue_option.issue_id)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @issue_option = IssueOption.find(params[:id])
    @issue_option.destroy
    flash[:notice] = "Successfully destroyed issue option."
    redirect_to new_issue_option_path(:active_issue=>@issue_option.issue_id)
  end
end
