class FacilitatorGroupsController < ApplicationController
  def index
    @facilitator_groups = FacilitatorGroup.all
  end

  def show
    @facilitator_group = FacilitatorGroup.find(params[:id])
  end

  def new
    @facilitator_group = FacilitatorGroup.new
  end

  def create
    @facilitator_group = FacilitatorGroup.new(params[:facilitator_group])
    if @facilitator_group.save
      flash[:notice] = "Successfully created facilitator group."
      redirect_to facilitator_group_path(@facilitator_group, :check_form=>"true")
    else
      render :action => 'new'
    end
  end

  def edit
    @facilitator_group = FacilitatorGroup.find(params[:id])
  end

  def update
    @facilitator_group = FacilitatorGroup.find(params[:id])
    if @facilitator_group.update_attributes(params[:facilitator_group])
      flash[:notice] = "Successfully updated facilitator group."
      redirect_to facilitator_group_path(@facilitator_group, :check_form=>"true")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @facilitator_group = FacilitatorGroup.find(params[:id])
    @facilitator_group.delete
    flash[:notice] = "Successfully destroyed facilitator group."
    redirect_to facilitator_groups_url
  end
end
