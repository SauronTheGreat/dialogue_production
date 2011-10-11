class PlayerScorecardsController < ApplicationController
  
  def end_negotiation
    @active_game=Game.find(params[:active_game])
    @all_issues=Issue.all(:conditions=>['case_study_id=?',@active_game.case_study_id])

  end

  def index
    @player_scorecards = PlayerScorecard.all
  end

  def show
    @player_scorecard = PlayerScorecard.find(params[:id])
  end

  def new
    @player_scorecard = PlayerScorecard.new
  end

  def create
    @player_scorecard = PlayerScorecard.new(params[:player_scorecard])
    if @player_scorecard.save
      flash[:notice] = "Successfully created player scorecard."
      redirect_to @player_scorecard
    else
      render :action => 'new'
    end
  end

  def edit
    @player_scorecard = PlayerScorecard.find(params[:id])
  end

  def update
    @player_scorecard = PlayerScorecard.find(params[:id])
    if @player_scorecard.update_attributes(params[:player_scorecard])
      flash[:notice] = "Successfully updated player scorecard."
      redirect_to @player_scorecard
    else
      render :action => 'edit'
    end
  end

  def destroy
    @player_scorecard = PlayerScorecard.find(params[:id])
    @player_scorecard.destroy
    flash[:notice] = "Successfully destroyed player scorecard."
    redirect_to player_scorecards_url
  end
end
