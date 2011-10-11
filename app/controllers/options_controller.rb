class OptionsController < ApplicationController
  # GET /options
  # GET /options.xml
  def index

    @question=Question.find(params[:question_id])
    @options = @question.options

    @no_of_options=0
    if (@question.type_id != 3)
      if (@question.type_id==1)
        @no_of_options=4

      else
        @no_of_options=2
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @options }
    end
  end

  # GET /options/1
  # GET /options/1.xml
  def show
    @option = Option.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @option }
    end
  end

  # GET /options/new
  # GET /options/new.xml
  def new
    @question=Question.find(params[:question_id])
    @options = @question.options

    @options = Array.new(4) { Option.new }


    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @option }
    end
  end

  # GET /options/1/edit
  def edit

    @option = Option.find(params[:id])
  end

  # POST /options
  # POST /options.xml
  def create
    #@option = Option.new(params[:option])

    @options = params[:options].values.collect { |option| Option.new(option) }
    @options.each do |o|
      o.save
    end
    @question=Question.find(@options[0].question_id)
    respond_to do |format|
      format.html { redirect_to questionnaire_path(:id=>@question.questionnaire.id, :check_form=>"true") }
      format.xml { render :xml => @option, :status => :created, :location => @option }
    end
  end

# PUT /options/1
# PUT /options/1.xml
def update
  @option = Option.find(params[:id])

  respond_to do |format|
    if @option.update_attributes(params[:option])
      format.html { redirect_to(@option, :notice => 'Options were successfully updated.') }
      format.xml { head :ok }
    else
      format.html { render :action => "edit" }
      format.xml { render :xml => @option.errors, :status => :unprocessable_entity }
    end
  end
end

# DELETE /options/1
# DELETE /options/1.xml
def destroy
  @option = Option.find(params[:id])
  @qid=@option.question_id
  @option.destroy

  respond_to do |format|
    format.html { redirect_to(options_url(:qid=>@qid)) }
    format.xml { head :ok }
  end
end

end
