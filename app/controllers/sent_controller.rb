class SentController < ApplicationController
  def rulelist
    @active_game=Game.find(params[:active_game])
    if @player!=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @student_group=@player.game.student_group
    @allrules=StudentGroupRule.all(:conditions=>['student_group_id=?',@student_group.id])
  
    render :layout => false
  end

  def scorelist
    @active_game=Game.find(params[:active_game])
    if @player!=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @student_group=@player.game.student_group
    @allrules=StudentGroupRule.all(:conditions=>['student_group_id=?',@student_group.id])

    render :layout => false
  end

  def index
    @active_game=Game.find(params[:active_game])
    if @player!=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @messages = @player.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
  end

  def show
    @active_game=Game.find(params[:active_game])
    if @player!=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @message = @player.sent_messages.find(params[:id])
  end

  def new
    @active_game=Game.find(params[:active_game])
    if @player!=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @message = @player.sent_messages.build
  end

  def create
    @active_game=Game.find(params[:active_game])
    if @player!=Player.find(:first,:conditions=>["user_id=? and game_id=?",current_user.id,@active_game.id])
      @player=Player.find(params[:active_player])
    end
    @message = @player.sent_messages.build(params[:message])

    if @message.save
      @offer=Offer.new
      @offer.game_id=@active_game.id
      @offer.offerer=@player.id
      if @message.offer then
        @offer.value=@message.offer
      else
        if @oldoffer=Offer.find(:last,:conditions=>['game_id=? and offerer=?',@active_game.id,@player.id],:order=>'created_at ASC')
          @offer.value=@oldoffer.value
        else
          @offer.value=0
        end
      end
      if @lastoffersq=Offer.find(:last,:conditions=>['game_id=?',@active_game.id],:order=>'created_at ASC')
        @offer.sequence=@lastoffersq.sequence+1
      else
        @offer.sequence=1
      end
      @offer.save

      @case_study=CaseStudy.find(@active_game.case_study_id)
      @roles=Role.all(:conditions=>['case_study_id=?',@case_study.id])
      @playeridforrole=Array.new

      @myrole=@player.role
      @roles.delete_if { |role| role == @myrole }

      @roles.count.times do |index|
        @playeridforrole[index] = Player.find(:first,:conditions=>['game_id=? and role_id=?',@active_game.id,@roles[index].id]).id
        @otheroffer=Offer.new
        @otheroffer.game_id=@active_game.id
        @otheroffer.offerer=@playeridforrole[index]

        if @oldotheroffer=Offer.find(:last,:conditions=>['game_id=? and offerer=?',@active_game.id,@playeridforrole[index]],:order=>'created_at ASC')
          @otheroffer.value=@oldotheroffer.value
        else
          @otheroffer.value=0
        end

        @otheroffer.sequence=@offer.sequence
        @otheroffer.save
      end
      flash[:notice] = "Message sent."
      redirect_to :action => "index", :active_game=>@active_game.id, :active_player=>@player.id
    else
      render :action => "new"
    end
  end

end
