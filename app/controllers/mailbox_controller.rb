class MailboxController < ApplicationController
  def index
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @folder = @player.inbox
    show
    render :action => "show"
  end

  def show
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @folder ||= @player.folders.find(params[:id])
    @messages = @folder.messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
  end

end
