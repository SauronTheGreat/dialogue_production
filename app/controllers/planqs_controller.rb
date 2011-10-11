class PlanqsController < ApplicationController
  def index
    @planqs = Planq.all
  end

  def show
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @planqnav=Planq.find(params[:id])
  end

  def new
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @case_study=CaseStudy.find(@active_game.case_study_id)
    @role=Role.find(@player.role_id)
    @issues= Issue.all(:conditions=>['case_study_id=?',@case_study.id])
    @issue_count= @issues.count


    @planqs = Array.new((@issue_count*2)+3) { Planq.new }

  end

  def create

    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @case_study=CaseStudy.find(@active_game.case_study_id)
    @role=Role.find(@player.role_id)
    @issues= Issue.all(:conditions=>['case_study_id=?',@case_study.id])


    @survey_responses = params[:planqs].values.collect {|survey_response| Planq.new(survey_response) }

    if @survey_responses.all?(&:valid?)
      @survey_responses.each do |survey_response|
        if @existing_response=Planq.find(:first,:conditions=>['player_id=? and name=? and meyou=?',@player.id,survey_response.name,survey_response.meyou])
          @existing_response.destroy
          survey_response.save!
        else
          survey_response.save!
        end
      end
      render :action => 'show', :active_game=>@active_game.id

    else
      render :action => 'new'
    end
  end

  def edit
    @planq = Planq.find(params[:id])
  end

  def update
    @planq = Planq.find(params[:id])
    if @planq.update_attributes(params[:planq])
      flash[:notice] = "Successfully updated planq."
      redirect_to @planq
    else
      render :action => 'edit'
    end
  end

  def destroy
    @planq = Planq.find(params[:id])
    @planq.destroy
    flash[:notice] = "Successfully destroyed planq."
    redirect_to planqs_url
  end
end
