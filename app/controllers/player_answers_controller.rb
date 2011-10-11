class PlayerAnswersController < ApplicationController
  # GET /player_answers
  # GET /player_answers.xml
  def index
    @player_answers = PlayerAnswer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @player_answers }
    end
  end

  # GET /player_answers/1
  # GET /player_answers/1.xml
  def show
    @player_answer = PlayerAnswer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @player_answer }
    end
  end

  # GET /player_answers/new
  # GET /player_answers/new.xml
  def new
    #@player_answer = PlayerAnswer.new
    @game=Game.find(Player.find(params[:id]).game_id)
    @student_group=StudentGroup.find(@game.student_group_id)
    if (Questionnaire.all.count > 0)

      if (params[:prequestionnaire].to_i==1)
        if (!@student_group.pre_questionnaire_id.nil?)
          @questionnaire=Questionnaire.find(@student_group.pre_questionnaire_id)
        end
      else
        if (!@student_group.post_questionnaire_id.nil?)
          @questionnaire=Questionnaire.find(@student_group.post_questionnaire_id)
        end
      end
    end
    @player_answers=Array.new(@questionnaire.questions.count) { PlayerAnswer.new }
    @questions=@questionnaire.questions
    if (!@questionnaire.nil?)
      respond_to do |format|
        format.html # new.html.erb
        format.xml { render :xml => @player_answer }
      end
    else
      if (params[:questionnaire]==1)
        redirect_to(:controller=>:welcome, :action=>'index', :active_game=>@game.id)
      else
        redirect_to(agreed_path(:active_game=>@game.id))
      end

    end
  end


  # GET /player_answers/1/edit
  def edit
    @player_answer = PlayerAnswer.find(params[:id])
  end

  # POST /player_answers
  # POST /player_answers.xml
  def create
    @game=Game.find(Player.find_by_user_id(current_user.id).game_id)
    @player_answers = params[:player_answers].values.collect { |player_answer| PlayerAnswer.new(player_answer) }

    if @player_answers.all?(&:valid?)
      @player_answers.each do |p|
        p.save
      end

    end
    @student_routing=StudentRouting.find_by_player_id(Player.find_by_user_id(current_user.id).id)
    @student_routing.pre_neg_taken=true
    @student_routing.save

    if @player_answers.all?(&:valid?)
      respond_to do |format|
        format.html { redirect_to(:controller=>:welcome, :action=>'index', :notice => 'Player answer was successfully created.', :active_game=>@game.id) }
        format.xml { render :xml => @player_answer, :status => :created, :location => @player_answer }
      end
    else
      respond_to do |format|
        format.html { redirect_to :action => "new", :id=>Player.find_by_user_id(current_user.id), :active_game=>@game.id, :prequestionnaire => 1, :error=>"incomplete form" }
        format.xml { render :xml => @player_answer.errors, :status => :unprocessable_entity }
      end
    end
  end


  def createpost
    @game=Game.find(Player.find_by_user_id(current_user.id).game_id)
    @player_answers = params[:player_answers].values.collect { |player_answer| PlayerAnswer.new(player_answer) }

    if @player_answers.all?(&:valid?)
      @player_answers.each do |p|
        p.save


      end

    end
    @student_routing=StudentRouting.find_by_player_id(Player.find_by_game_id(@game.id).id)
    @student_routing.post_neg_taken=true
    @student_routing.save

    if @player_answers.all?(&:valid?)
      respond_to do |format|
        format.html { redirect_to(agreed_path(:active_game=>@game.id)) }
        format.xml { render :xml => @player_answer, :status => :created, :location => @player_answer }
      end
    else
      respond_to do |format|
        format.html { redirect_to :action => "new", :id=>Player.find_by_user_id(current_user.id), :active_game=>@game.id, :prequestionnaire => 0, :error=>"Incomplete form" }
        format.xml { render :xml => @player_answer.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /player_answers/1
  # PUT /player_answers/1.xml
  def update
    @player_answer = PlayerAnswer.find(params[:id])

    respond_to do |format|
      if @player_answer.update_attributes(params[:player_answer])
        format.html { redirect_to(@player_answer, :notice => 'Player answer was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @player_answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /player_answers/1
  # DELETE /player_answers/1.xml
  def destroy
    @player_answer = PlayerAnswer.find(params[:id])
    @player_answer.destroy

    respond_to do |format|
      format.html { redirect_to(player_answers_url) }
      format.xml { head :ok }
    end
  end
end
