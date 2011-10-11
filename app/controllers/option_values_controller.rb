class OptionValuesController < ApplicationController
  def index
    @option_values = OptionValue.all
  end

  def show
    @option_value = OptionValue.find(params[:id])
  end

  def new
    @issue=Issue.find(params[:active_issue])
    @alloptions= IssueOption.all(:conditions=>['issue_id=?',@issue.id])
    @allroles= Role.all(:conditions=>['case_study_id=?',@issue.case_study_id])

    @ocount=@alloptions.count
    @rcount=@allroles.count
    @option_values = Array.new(@ocount*@rcount) { OptionValue.new }

  end

  def create

    @issue=Issue.find(params[:active_issue])
    @option_values = params[:option_values].values.collect { |option_value| OptionValue.new(option_value) }

    if @option_values.all?(&:valid?)
      @option_values.each do |option_value|
        if @ex_opt=OptionValue.find(:first,:conditions=>['issue_option_id=? and role_id=?',option_value.issue_option_id,option_value.role_id])
          @ex_opt.destroy
          option_value.save!
        else
          option_value.save!
        end
      end
    end
    redirect_to new_issue_option_path(:active_issue=>@issue.id)
  end

  def edit
    @option_value = OptionValue.find(params[:id])
  end

  def update
    @option_value = OptionValue.find(params[:id])
    if @option_value.update_attributes(params[:option_value])
      flash[:notice] = "Successfully updated option value."
      redirect_to @option_value
    else
      render :action => 'edit'
    end
  end

  def destroy
    @option_value = OptionValue.find(params[:id])
    @option_value.destroy
    flash[:notice] = "Successfully destroyed option value."
    redirect_to option_values_url
  end
end
