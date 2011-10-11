class MessagesController < ApplicationController

  def show
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @message = @player.received_messages.find(params[:id])
  end

  def reply
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @original = @player.received_messages.find(params[:id])

    subject = @original.subject.sub(/^(Re: )?/, "Re: ")
    body = @original.body.gsub(/^/, "> ")
    @message = @player.sent_messages.build(:to => [@original.author.id], :subject => subject, :body => body)
    render :template => "sent/new"
  end

  def forward
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @original = @player.received_messages.find(params[:id])

    subject = @original.subject.sub(/^(Fwd: )?/, "Fwd: ")
    body = @original.body.gsub(/^/, "> ")
    @message = @player.sent_messages.build(:subject => subject, :body => body)
    render :template => "sent/new"
  end

  def reply_all
    @active_game=Game.find(params[:active_game])
    if !@player=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @original = @player.received_messages.find(params[:id])

    subject = @original.subject.sub(/^(Re: )?/, "Re: ")
    body = @original.body.gsub(/^/, "> ")
    recipients = @original.recipients.map(&:id) - [@player.id] + [@original.author.id]
    @message = @player.sent_messages.build(:to => recipients, :subject => subject, :body => body)
    render :template => "sent/new"
  end

end
