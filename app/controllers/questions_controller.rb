class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  def index
    if (params[:qid].nil?)
      @questions = Question.all
    else
      @questionnaire=Questionnaire.find(params[:qid])
      @questions = @questionnaire.questions

    end
    respond_to do |format|
      format.html # index.html.erb                 s
      format.xml { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    @questionnaire=Questionnaire.find(params[:qid])


    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @questionnaire_id=params[:question][:questionnaire_id]

    respond_to do |format|
      if @question.save
        if Type.find(@question.type_id).name=="Multiple Choice Question"
          format.html { redirect_to new_option_path(:question_id=>@question.id, :check_form=>"true") }
        elsif Type.find(@question.type_id).name=="True/False"
          @option_true=Option.new
          @option_true.question_id=@question.id
          @option_true.name="True"
          @option_true.save
          @option_false=Option.new
          @option_false.question_id=@question.id
          @option_false.name="False"
          @option_false.save
        elsif Type.find(@question.type_id).name=="5-Point Rating Scale"
          @option1=Option.new
          @option1.question_id=@question.id
          @option1.name="Strongly Agree"
          @option1.save
          @option2=Option.new
          @option2.question_id=@question.id
          @option2.name="Agree"
          @option2.save
          @option3=Option.new
          @option3.question_id=@question.id
          @option3.name="Indifferent"
          @option3.save
          @option4=Option.new
          @option4.question_id=@question.id
          @option4.name="Disagree"
          @option4.save
          @option5=Option.new
          @option5.question_id=@question.id
          @option5.name="Strongly Disagree"
          @option5.save
        elsif Type.find(@question.type_id).name=="7-Point Rating Scale"
          @option1=Option.new
          @option1.question_id=@question.id
          @option1.name="Strongly Agree"
          @option1.save
          @option2=Option.new
          @option2.question_id=@question.id
          @option2.name="Quite Agree"
          @option2.save
          @option3=Option.new
          @option3.question_id=@question.id
          @option3.name="Agree"
          @option3.save
          @option4=Option.new
          @option4.question_id=@question.id
          @option4.name="Indifferent"
          @option4.save
          @option5=Option.new
          @option5.question_id=@question.id
          @option5.name="Disagree"
          @option5.save
          @option6=Option.new
          @option6.question_id=@question.id
          @option6.name="Quite Disagree"
          @option6.save
          @option7=Option.new
          @option7.question_id=@question.id
          @option7.name="Strongly Disagree"
          @option7.save
        else
        end
        format.html { redirect_to questionnaire_path(:id=>@question.questionnaire.id, :check_form=>"true") }
      else
        format.html { redirect_to(questionnaire_path(:id=>@questionnaire_id, :check_form=>"true", :sgid=>params[:sgid], :flag=>params[:flag])) }
        format.xml { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questionnaire_path(:id=>@question.questionnaire_id) }
      format.xml { head :ok }
    end
  end

  def list
    @sgid=params[:sgid]
    @questionnaire=Questionnaire.find(params[:qid])
    @flag=params[:flag]
    @questions=@questionnaire.questions
  end
end
