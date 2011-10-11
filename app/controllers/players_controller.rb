class PlayersController < ApplicationController

  def plandoc
    @active_game=Game.find(params[:active_game])
    @player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
    @case_study=CaseStudy.find(@active_game.case_study_id)
    @role=Role.find(@player.role_id)
    @issues= Issue.all(:conditions=>['case_study_id=?',@case_study.id])
  end

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])
	@student_routing=StudentRouting.new

    if @player.save
	  @student_routing.player_id=@player.id
	  @student_routing.save
      flash[:notice] = "Successfully created player."
      redirect_to @player
    else
      render :action => 'new'
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      flash[:notice] = "Successfully updated player."
      redirect_to @player
    else
      render :action => 'edit'
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    flash[:notice] = "Successfully destroyed player."
    redirect_to players_url
  end
end
