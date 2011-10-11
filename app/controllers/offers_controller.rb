class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(params[:offer])
    if @offer.save
      flash[:notice] = "Successfully created offer."
      redirect_to @offer
    else
      render :action => 'new'
    end
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.update_attributes(params[:offer])
      flash[:notice] = "Successfully updated offer."
      redirect_to @offer
    else
      render :action => 'edit'
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    flash[:notice] = "Successfully destroyed offer."
    redirect_to offers_url
  end
end
