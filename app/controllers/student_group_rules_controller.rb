class StudentGroupRulesController < ApplicationController
  # GET /student_group_rules
  # GET /student_group_rules.xml
  def index
    @student_group_rules = StudentGroupRule.all
    @student_group = StudentGroup.find(params[:sg])
    @rules = StudentGroupRule.find_all_by_student_group_id(params[:sg_id])


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @student_group_rules }
    end
  end

  # GET /student_group_rules/1
  # GET /student_group_rules/1.xml
  def show
    @student_group_rule = StudentGroupRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_group_rule }
    end
  end

  # GET /student_group_rules/new
  # GET /student_group_rules/new.xml
  def new
    @student_group = StudentGroup.find(params[:student_group])
    @student_group_rules = Array.new(Rule.all.count) { StudentGroupRule.new }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_group_rule }
    end
  end

  # GET /student_group_rules/1/edit
  def edit
    @student_group_rule = StudentGroupRule.find(params[:id])
  end

  # POST /student_group_rules
  # POST /student_group_rules.xml
  def create
    @student_group_rules = params[:student_group_rules].values.collect { |student_group_rule| StudentGroupRule.new(student_group_rule) }
    if @student_group_rules.all?(&:valid?)
      @allrules=Rule.all.count
      @i=0
      @student_group_rules.each do |sgr|
        @sg=sgr.student_group_id
        @i+=1
        if sgr.rule
          sgr.save! unless StudentGroupRule.find(:first,:conditions=>["student_group_id=? and rule_id=?",sgr.student_group_id,sgr.rule_id])
        else
          @exsgr.destroy if @exsgr=StudentGroupRule.find(:first,:conditions=>["student_group_id=? and rule_id=?",sgr.student_group_id,@i])
        end
      end
      redirect_to StudentGroup.find(@sg)
    else
      render :action => 'new'
    end
  end

  # PUT /student_group_rules/1
  # PUT /student_group_rules/1.xml
  def update
    @student_group_rule = StudentGroupRule.find(params[:id])

    respond_to do |format|
      if @student_group_rule.update_attributes(params[:student_group_rule])
        format.html { redirect_to(@student_group_rule, :notice => 'StudentGroupRule was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student_group_rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /student_group_rules/1
  # DELETE /student_group_rules/1.xml
  def destroy
    @student_group_rule = StudentGroupRule.find(params[:id])
    @student_group_rule.destroy

    respond_to do |format|
      format.html { redirect_to(student_group_rules_url) }
      format.xml  { head :ok }
    end
  end

  def rules_by_group
    rules = StudentGroupRule.find_all_by_student_group_id(params[:id])
    render :partial => "rules", :locals => { :rules => rules }
  end

end
