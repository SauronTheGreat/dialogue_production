class StudentGroupsController < ApplicationController

  require 'spreadsheet'

  def index
    if current_user.admin
      @student_groups = StudentGroup.all
    else
      @facgroup=FacilitatorGroup.find(:first, :conditions=>["user_id=?", current_user.id])
      @student_groups = StudentGroup.all(:conditions=>['facilitator_group_id=?', @facgroup.id])
    end
  end

  def show
    @student_group = StudentGroup.find(params[:id])
  end

  def new
    @student_group = StudentGroup.new
  end

  def create
    @student_group = StudentGroup.new(params[:student_group])
    if @student_group.save
      flash[:notice] = "Successfully created student group."
      redirect_to @student_group
    else
      render :action => 'new'
    end
  end


  def edit
    @student_group = StudentGroup.find(params[:id])
  end

  def update
    @student_group = StudentGroup.find(params[:id])
    if @student_group.update_attributes(params[:student_group])
      flash[:notice] = "Successfully updated student group."
      redirect_to @student_group
    else
      render :action => 'edit'
    end
  end

  def destroy
    @student_group = StudentGroup.find(params[:id])
    @student_group.destroy
    flash[:notice] = "Successfully destroyed student group."
    redirect_to student_groups_url
  end

  def add_facilitator
    @student_group = StudentGroup.find(params[:id])
  end

  def add_case_study
    @student_group = StudentGroup.find(params[:id])
  end

  def add_pre_exercise_survey
    @student_group = StudentGroup.find(params[:id])
  end

  def add_post_exercise_survey
    @student_group = StudentGroup.find(params[:id])
  end

  def create_games
    @student_group = StudentGroup.find(params[:id])
    @studentgroupuserlist=StudentGroupUser.all(:conditions=>['student_group_id=?', params[:id]])
    @studentlist= Array.new
    @unallocated_student= Array.new
    @studentgroupuserlist.each do |s|
      @studentlist << User.find(s.user_id)
    end

    #this filters the allocated students
    @tmps=Temp.find(:all)
    if (@tmps.count!=0)
      @tmps.each do |t|
        @studentlist.each do |s|
          if (t.user_id==s.id)
            @studentlist.delete(s)
          end
        end
      end
    end

    Temp.destroy_all


    #This is where pairing code comes

    @games_ids=Array.new
    @number_of_paired_players=Array.new
    @paired_players=Array.new
    @number_of_unpaired_players=Array.new
    @unpaired_players=Array.new

    @studentlist.each do |s|
      @games_ids[s.id]=Array.new
      @number_of_paired_players[s.id]=Array.new
      @paired_players[s.id]=Array.new
      @number_of_unpaired_players[s.id]=0
      @unpaired_players[s.id]=Array.new
    end

    @studentlist.each do |s|

      players=Player.find_all_by_user_id(s.id)
      players.each do |p|
        @games_ids[s.id] << p.game_id
      end
    end

    p=0
    up=0
    @studentlist.each do |s|
      for i in 0..@studentlist.count-1
        @number_of_paired_players[s.id][@studentlist[i].id] =0
        if (@studentlist[i].id != s.id)


          for j in 0..@games_ids[s.id].size
            if (@games_ids[@studentlist[i].id][j] == @games_ids[s.id][j])
              @number_of_paired_players[s.id][@studentlist[i].id]=@number_of_paired_players[s.id][@studentlist[i].id]+1

            end
          end
        end
      end
    end

    #now we have the information which player is linked to how many players and who are the players

    #end of pairing code


    @t=Array.new
    @t=(0..@studentlist.count-1).sort_by { rand }

    j=0

    @studentlist.each do |s|

      min=0

      for i in 0..@studentlist.count-1
        if (min > @number_of_paired_players[s.id][@studentlist[i].id])
          min= @number_of_paired_players[s.id][@studentlist[i].id]
          t[j]= @studentlist[i].id
        end

      end
      j=j+1

    end


    @studentcount=@studentlist.count

    @rolelist=Role.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
    @rolecount=@rolelist.count

    @gamecount=@studentcount/@rolecount
    @leftover=@studentcount-(@gamecount*@rolecount)

    @userindex=0


    i=0
    @players=Array.new
    @gamecount.times do |inst|
      @make_game=Game.new
      @make_game.case_study_id=@student_group.case_study_id
      @make_game.student_group_id=@student_group.id
      @make_game.agreement_status=FALSE
      @make_game.status=TRUE
      @make_game.save


      @rolecount.times do |rc|
        @new_player=Player.new
        # r=rand((@studentlist.count-1))

        @new_player.user_id=@studentlist[@t[i].to_i].id
        @t.delete_at(i)
        @new_player.game_id=@make_game.id
        @new_player.role_id=@rolelist[rc].id
        @new_player.save
        @student_routing=StudentRouting.new
        @student_routing.player_id=@new_player.id

        if @student_group.pre_questionnaire_id and @student_group.pre_questionnaire_id !=0
          @student_routing.pre_neg_required=true
        end
        if @student_group.post_questionnaire_id and @student_group.post_questionnaire_id !=0
          @student_routing.post_neg_required=true
        end
        if StudentGroupRule.first(:conditions => ['student_group_id=? and rule_id=?',@student_group.id,1])
          @student_routing.planning_required=true
        end

        @student_routing.save

        @players << @new_player
        @userindex+=1
        # i=i+1
      end

    end


    @t.count.times do |lef|
      @unallocated_student<<@studentlist[@t[lef]]
    end


    @allissues=Issue.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
    @allroles=Role.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
    @allgames=Game.all(:conditions=>['student_group_id=?', @student_group.id])
    @allgames.each do |game|
      @allplayers=Player.all(:conditions=>['game_id=?', game.id])
      @allplayers.each do |player|
        @allissues.each do |issue|
          @player_scorecard=PlayerScorecard.new
          @player_scorecard.player_id=player.id
          @player_scorecard.issue_id=issue.id
          @player_scorecard.save
        end
      end
    end

    @rolecount.times do |rc|
    end


  end


#this method is called when proceed to game creation is pressed
  def game_creation


    @student_group = StudentGroup.find(params[:id])
    if !Game.find(:first, :conditions=>["student_group_id=?", @student_group.id]).blank?
      @allgames=Game.all(:conditions=>["student_group_id=?", @student_group.id])
      @allgames.each do |game|
        game.destroy
      end
    end

  end


  def create_games_manual

    @student_group = StudentGroup.find(params[:id])
    @studentgroupuserlist=StudentGroupUser.all(:conditions=>['student_group_id=?', params[:id]])
    @studentlist= Array.new
    @unallocated_student= Array.new
    @studentgroupuserlist.each do |s|
      @studentlist << User.find(s.user_id)
    end
    @tmps=Temp.find(:all)
    if (@tmps.count!=0)
      @tmps.each do |t|
        @studentlist.each do |s|
          if (t.user_id==s.id)
            @studentlist.delete(s)
          end
        end
      end
    end


    @player_info=Array.new
    @studentlist.each do |s|
      @player_info << s.first_name+s.last_name+"  "+s.id.to_s
    end

    @rolelist=Role.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
  end

#this method is called when user submits the form
  def assign_roles_manual


    @student_group = StudentGroup.find(params[:id])
    @rolelist=Role.find(:all, :conditions=>['case_study_id=?', @student_group.case_study_id])
    s="player"

    #perform  validation
    @tmp=Array.new
    @msg=1
    @flag=0

    @rolelist.count.times do |i|
      @tmp[i]=0
    end
    i=0
    @rolelist.each do |r|

      s="player"+(r.id).to_s
      @name=params[s.to_sym]

      #@name=@name[@name.size-1].to_i
      @name=@name.partition("  ")[2].to_i

      #@name=@name.partition(" ")[2].to_s+" "
      @tmp.each do |tmp|
        if (tmp==@name)
          @flag=1
        end
      end
      @tmp << @name
      #@user=User.find(@name)
    end

    if (@flag==1)
      @msg=1
      redirect_to :action => 'create_games_manual', :id=>params[:id], :msg=>@msg
    else
      #this creates the game
      @make_game=Game.new
      @make_game.case_study_id=@student_group.case_study_id
      @make_game.student_group_id=@student_group.id
      @make_game.agreement_status=FALSE
      @make_game.status=TRUE
      @make_game.save


      @players=Array.new


      @rolelist.each do |r|
        s="player"+(r.id).to_s
        @name=params[s.to_sym]
        @name=@name.partition("  ")[2].to_i
        # @name=@name.partition(" ")[2].to_s+" "
        #@name=@name[@name.size-1].to_i
        @user=User.find(@name)


        #This creates a new player
        @new_player=Player.new
        @new_player.user_id=@user.id
        @new_player.game_id=@make_game.id
        @new_player.role_id=r.id
        @new_player.save
        @student_routing=StudentRouting.new
        @student_routing.player_id=@new_player.id

        if @student_group.pre_questionnaire_id and @student_group.pre_questionnaire_id !=0
          @student_routing.pre_neg_required=true
        end
        if @student_group.post_questionnaire_id and @student_group.post_questionnaire_id !=0
          @student_routing.post_neg_required=true
        end
        if StudentGroupRule.first(:conditions => ['student_group_id=? and rule_id=?',@student_group.id,1])
          @student_routing.planning_required=true
        end

        @student_routing.save
        @players << @new_player
        #I am putting all allocated players(users ids of the players)  in the database
        @tmp=Temp.new
        @tmp.user_id=@new_player.user_id
        @tmp.save
      end
      @x=Array.new
      @y=Array.new


      @players.each { |p| @x << p.user_id }
      #This stores info about unallocated users
      @tmps=Temp.find(:all)
      @leftover_students=Array.new
      @student_group_user=StudentGroupUser.find_all_by_student_group_id(@student_group.id)
      @student_group_user.each { |sgu| @y << sgu.user_id }
      @unallocated_students=@y-@x
      @tmps.each do |t|
        @unallocated_students.each do |ul|

          if (t.user_id==ul)
            @unallocated_students.delete(ul)
          end
        end
      end

      @unallocated_students.each do |ul|
        @u=User.find(ul)
        @leftover_students << @u
      end
      if (@leftover_students.count < @rolelist.count)
        Temp.destroy_all
      end


      # here all issues and scorecards are created
      @allissues=Issue.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
      @allroles=Role.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
      @allgames=Game.all(:conditions=>['student_group_id=?', @student_group.id])
      @allgames.each do |game|
        @allplayers=Player.all(:conditions=>['game_id=?', game.id])
        @allplayers.each do |player|
          @allissues.each do |issue|
            @player_scorecard=PlayerScorecard.new
            @player_scorecard.player_id=player.id
            @player_scorecard.issue_id=issue.id
            @player_scorecard.save
          end
        end
      end


    end
    redirect_to :action => 'create_games_manual', :id=>params[:id]

  end

###################################################################
#manual assigment ends here

#starting with excel assingment


  def create_games_excel

    if (params[:msg].nil?)

      @student_group = StudentGroup.find(params[:id])
      #@book = Spreadsheet.open 'C:/Users/Rushabh Hathi/Desktop/Dialogue1.0/public/Files/abc.txt'
      @book = Spreadsheet::Workbook.new
      sheet1 = @book.create_worksheet
      @rolelist=Role.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
      i=1

#    #here role name is  added for the list to be populated
#    @rolelist.each do |r|
#      sheet1[0, i]=r.name
#      i=i+1
#    end

      @studentgroupuserlist=StudentGroupUser.all(:conditions=>['student_group_id=?', params[:id]])
      @studentlist= Array.new
      @unallocated_student= Array.new
      @studentgroupuserlist.each do |s|
        @studentlist << User.find(s.user_id)
      end

      #here the dynamic data from student group gets populated
      i=1
      sheet1[0, 0]="Student ID"
      sheet1[0, 1]="Student Name"
      sheet1[0, 2]="Role Name"


      @studentlist.each do |s|

        sheet1[i, 0]=s.id
        sheet1[i, 1]=s.first_name+s.last_name
        sheet1[i, 2]= " "
        i=i+1
        @book.write "#{Rails.root}/public/Files/Game_Creation.xls"


      end

    end
  end

  def assign_roles_excel


    @student_group = StudentGroup.find(params[:id])
    @rolelist=Role.all(:conditions=>['case_study_id=?', @student_group.case_study_id])

    @studentgroupuserlist=StudentGroupUser.all(:conditions=>['student_group_id=?', params[:id]])
    @studentlist= Array.new

    @studentgroupuserlist.each do |s|
      @studentlist << User.find(s.user_id)
    end


    #my format is:
    # studentid,student name,rolename

    @x=Array.new
    @student_group = StudentGroup.find(params[:id])
    @import =Import.find(params[:imid])
    @path=@import.csv.path.to_s

    # book = Spreadsheet.open 'C:/Users/Rushabh Hathi/Desktop/Dialogue1.0/public/Files/abcd.xls'
    book=Spreadsheet.open @path
    sheet1 = book.worksheet 0

    @student_names=Array.new
    @role_names=Array.new
    @student_ids=Array.new

    for i in 1..@studentlist.count
      if (sheet1[i, 1]!=" ")
        @student_names << sheet1[i, 1]
      end
      if (sheet1[i, 0]!=" ")
        @student_ids << sheet1[i, 0]
      end
      if (sheet1[i, 2]!=" ")
        @role_names << sheet1[i, 2]
      end
    end


    @number_of_games=@studentlist.count/@rolelist.count

    #this is the validation code
    @k=Array.new
    for i in 0..@rolelist.count
      @k[i]=0
    end


    if (!@role_names.blank? and !@student_names.blank? and !@student_ids.blank?)
      @role=Role.new
      tmp=" "
      i=0
      @role_names.each do |r|
        if (r.to_s!="Unallocated")
          @role=Role.find_by_name(@role_names[i])
          @k[@role.id]=@k[@role.id]+1
        end
        i=i+1

      end
    else

      redirect_to :action => 'create_games_excel', :id => params[:id], :msg => "Blank Columns Found !!" and return
    end
    i=0
    @k.each do |m|
      if (@k[i].to_i > @number_of_games)
        @k=1
        redirect_to :action => 'create_games_excel', :id => params[:id], :msg => "Role assignment error ! "
      end
      i=i+1
    end
    #if the control comes here that means the document is valid

    @number_of_games.times do
      @make_game=Game.new
      @make_game.case_study_id=@student_group.case_study_id
      @make_game.student_group_id=@student_group.id
      @make_game.agreement_status=FALSE
      @make_game.status=TRUE
      @make_game.save
    end
    @unallocated_students=Array.new
    @players=Array.new
    i=0
    @student_ids.each do |s|
      @new_player=Player.new
      @new_player.user_id=s
      @new_player.game_id=@make_game.id
      if (@role_names[i]!="Unallocated")
        @role=Role.find_by_name(@role_names[i].to_s)
        @new_player.role_id=@role.id
        @new_player.save
        @student_routing=StudentRouting.new
        @student_routing.player_id=@new_player.id

        if @student_group.pre_questionnaire_id and @student_group.pre_questionnaire_id !=0
          @student_routing.pre_neg_required=true
        end
        if @student_group.post_questionnaire_id and @student_group.post_questionnaire_id !=0
          @student_routing.post_neg_required=true
        end
        if StudentGroupRule.first(:conditions => ['student_group_id=? and rule_id=?',@student_group.id,1])
          @student_routing.planning_required=true
        end

        @student_routing.save
        @players << @new_player
      else
        @new_player.role_id=0
        @unallocated_students << @new_player
      end


      i=i+1
    end

    @allissues=Issue.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
    @allroles=Role.all(:conditions=>['case_study_id=?', @student_group.case_study_id])
    @allgames=Game.all(:conditions=>['student_group_id=?', @student_group.id])
    @allgames.each do |game|
      @allplayers=Player.all(:conditions=>['game_id=?', game.id])
      @allplayers.each do |player|
        @allissues.each do |issue|
          @player_scorecard=PlayerScorecard.new
          @player_scorecard.player_id=player.id
          @player_scorecard.issue_id=issue.id
          @player_scorecard.save
        end
      end
    end


  end

  def download_data
    send_file ("#{Rails.root}/public/Files/Game_Creation.xls")
    #redirect_to :action => 'create_games_excel',:flag=>1
  end

  def populate_db
    @student_group=StudentGroup.find(params[:id].to_i)
    if (params[:flag]=="PostQuiz")

      @student_group.post_questionnaire_id= params[:qid].to_i
    else
      @student_group.pre_questionnaire_id= params[:qid].to_i
    end
    @student_group.save!

    #this is a block to state whether survey is required or not
    @student_group.players.each do |player|
      @student_routing=StudentRouting.find_by_player_id(player.id)
      @student_routing.post_neg_required=true
      @student_routing.pre_neg_required=true

      @student_routing.save!

    end
    redirect_to :action => 'show', :id=>@student_group.id
  end

  def switch_user
    @fac_id=current_user.id
    @user=User.find(params[:id])
    session[:preview]="yes"

    sign_in(:user, @user)
    @original_user = TempUser.new
    @original_user.user_id = @fac_id
    @original_user.save
    redirect_to root_path(:preview=>true)
  end


end

