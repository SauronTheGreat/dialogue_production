class GameDatasController < ApplicationController
  def student_view
    
  end

  def index
    @game_datas = GameData.all
  end

  def show
    @game_data = GameData.find(params[:active_game])
  end

  def new
    @game_data = GameData.new
  end

  def create
    @game_data = GameData.new(params[:game_data])
    if @game_data.save
      flash[:notice] = "Successfully created game data."
      redirect_to @game_data
    else
      render :action => 'new'
    end
  end

  def edit
    @game_data = GameData.find(params[:id])
  end

  def update
    @game_data = GameData.find(params[:id])
    if @game_data.update_attributes(params[:game_data])
      flash[:notice] = "Successfully updated game data."
      redirect_to @game_data
    else
      render :action => 'edit'
    end
  end

  def destroy
    @game_data = GameData.find(params[:id])
    @game_data.destroy
    flash[:notice] = "Successfully destroyed game data."
    redirect_to game_datas_url
  end
end
