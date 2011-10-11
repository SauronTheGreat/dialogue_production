class WelcomeController < ApplicationController
  def index
    if params[:active_game]
      @active_game=Game.find(params[:active_game])
    end
  end

  def game_select
  end

  def set_session_game
    redirect_to root_path(:active_game=>params[:active_game])
  end

  def switch_back
    @user=User.find(TempUser.first.user_id)
    sign_in(:user, @user)
    TempUser.destroy_all
    session[:preview]=nil
    redirect_to :root
  end

  def show_all
    @game=Game.find(params[:id])
    @studentgroup=StudentGroup.find(@game.student_group_id)
    @prequestionnaire=Questionnaire.find(@studentgroup.pre_questionnaire_id)
    @postquestionnaire=Questionnaire.find(@studentgroup.post_questionnaire_id)

  end
end
