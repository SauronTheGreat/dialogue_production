class ScoreqsController < ApplicationController
  def index
    @scoreqs = Scoreq.all
  end

  def show
    @current_scoreq=Scoreq.find(params[:id])
    @player=Player.find_by_user_id(current_user.id)
    @scoreqs = Scoreq.all(:conditions=>['player_id=? and message_id=?',@player.id,@current_scoreq.message_id])
    render :layout=> false
  end

  def new
    @active_game=Game.find(params[:active_game])
    @player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
    @message=Message.find(:first,:conditions=>["id=?",params[:active_message]])
    @metrics= StudentGroupMetric.all(:conditions=>['student_group_id=?',@player.game.student_group_id])
    @metric_count= @metrics.count

    @scoreqs = Array.new(@metric_count) { Metric.new }
    render :layout=> false
  end

  def create
    @active_game=Game.find(params[:active_game])
    @player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
    @metrics= StudentGroupMetric.all(:conditions=>['student_group_id=?',@player.game.student_group_id])
    @metric_count= @metrics.count


    @survey_responses = params[:scoreqs].values.collect {|survey_response| Scoreq.new(survey_response) }

    if @survey_responses.all?(&:valid?)
      @survey_responses.each do |survey_response|
        if @existing_response=Scoreq.find(:first,:conditions=>['player_id=? and student_group_metric_id=?',@player.id,survey_response.student_group_metric_id])
          @existing_response.destroy
          survey_response.save!
        else
          survey_response.save!
        end
      end
      #render :action => 'show', :id => Scoreq.first(:conditions=>['player_id=? and message_id=?',@player.id,params[:active_message]]).id:action => 'show', :id => Scoreq.first(:conditions=>['player_id=? and message_id=?',@player.id,params[:active_message]]).id
      render :text=>"Done"

    else
      render :action => 'new'
    end
  end

  def edit
    @scoreq = Scoreq.find(params[:id])
  end

  def update
    @scoreq = Scoreq.find(params[:id])
    if @scoreq.update_attributes(params[:scoreq])
      flash[:notice] = "Successfully updated scoreq."
      redirect_to @scoreq
    else
      render :action => 'edit'
    end
  end

  def destroy
    @scoreq = Scoreq.find(params[:id])
    @scoreq.destroy
    flash[:notice] = "Successfully destroyed scoreq."
    redirect_to scoreqs_url
  end
end
