class GameStatisticsController < ApplicationController
  layout "game_statistics", :except => [:download_email]

  def charting
    @active_game=Game.find(params[:active_game])
    @player=Player.find(:first, :conditions=>["user_id=? and game_id=?", current_user.id, @active_game.id])
    @case_study=CaseStudy.find(@active_game.case_study_id)
    @roles=Role.all(:conditions=>['case_study_id=?', @case_study.id])
    @colors = %w{#B40000 #F7941D #0265AC #DF5858 #FFC580 #6FAFF3 #5AAB6D #E99393 #9DCFA9 #A4CBF3}

    @playeridforrole=Array.new
    @offersbytherole=Array.new
    @playername=Array.new

    chart = Ambling::Data::LineColumnChart.new

    @maxoffers=0
    @roles.count.times do |index|
      @playeridforrole[index] = Player.find(:first, :conditions=>['game_id=? and role_id=?', @active_game.id, @roles[index].id]).id
      @offersbytherole[index] = Offer.find(:all, :conditions=>['game_id=? and offerer=?', @active_game.id, @playeridforrole[index]])
      @playername[index] = Player.find(@playeridforrole[index]).name
    end

    @lastoffer=Offer.find(:last, :conditions=>['game_id=?', @active_game.id], :order=>'created_at ASC')
    @numoffers=@lastoffer.sequence

    @numoffers.times do |index|
      xvalue=index+1
      chart.series << Ambling::Data::Value.new(xvalue.to_s, :xid => xvalue)
    end

    @roles.count.times do |index|
      chart.graphs << Ambling::Data::LineGraph.new([], :title => @playername[index], :color => @colors[index])
      @offersbytherole[index].each do |offer|
        chart.graphs.last << Ambling::Data::Value.new(offer.value.to_i, :xid => offer.sequence)
      end
    end

    render :xml => chart.to_xml
  end

  def offer_chart
    @active_game=Game.find(params[:active_game])
  end

  def data_viewer
    render :layout => 'application'
  end

  def download_data
    require 'spreadsheet'
    render :layout => 'application'

    @facilitator_group_id=FacilitatorGroup.first(:conditions=>['user_id=?', current_user.id]).id
    @allmy_student_groups=StudentGroup.all(:conditions=>['facilitator_group_id=?', @facilitator_group_id])
    @allmy_users_first_names=User.all(:select=>"DISTINCT first_name", :conditions=>['facilitator_group_id=?', @facilitator_group_id])
    @allmy_users_last_names=User.all(:select=>"DISTINCT last_name", :conditions=>['facilitator_group_id=?', @facilitator_group_id])

    if params[:searchgroup]=="All"
      @my_student_groups=StudentGroup.all(:conditions=>['facilitator_group_id=?', @facilitator_group_id])
    elsif params[:searchgroup]
      @my_student_groups = StudentGroup.find(:all, :conditions=>['facilitator_group_id=? and name LIKE ?', @facilitator_group_id, "%#{params[:searchgroup]}"])
    else
      @my_student_groups=StudentGroup.all(:conditions=>['facilitator_group_id=?', @facilitator_group_id])
    end
    @my_student_groups_ids=@my_student_groups.map { |i| i.id }
    @my_student_groups_cases=@my_student_groups.map { |i| i.case_study_id }
    @allmy_cases=CaseStudy.all(:conditions=>['id IN(?)', @my_student_groups_cases])
    @allmy_caseids=@allmy_cases.map { |i| i.id }
    @allmy_roles=Role.all(:conditions=>['case_study_id IN(?)', @allmy_caseids])
    @allmy_roleids=@allmy_roles.map { |i| i.id }


    if params[:searchcase]=="All"
      @my_cases=CaseStudy.all(:conditions=>['id IN(?)', @my_student_groups_cases])
    elsif params[:searchcase]
      @my_cases = CaseStudy.find(:all, :conditions=>['name LIKE ?', "%#{params[:searchcase]}"])
    else
      @my_cases=CaseStudy.all(:conditions=>['id IN(?)', @my_student_groups_cases])
    end
    @my_student_cases_ids=@my_cases.map { |i| i.id }

    @allgames=Game.all(:conditions=>['student_group_id IN(?) and case_study_id IN(?)', @my_student_groups_ids, @my_student_cases_ids]).map { |i| i.id }

    if params[:searchfirstname]=="All"
      if params[:searchlastname]=="All"
        @all_users=User.all.map { |i| i.id }
      elsif params[:searchlastname]
        @all_users = User.all(:conditions=>['last_name LIKE ?', "%#{params[:searchlastname]}"]).map { |i| i.id }
      else
        @all_users=User.all.map { |i| i.id }
      end
    elsif params[:searchfirstname]
      @all_users_fn = User.all(:conditions=>['first_name LIKE ?', "%#{params[:searchfirstname]}"]).map { |i| i.id }
      if params[:searchlastname]=="All"
        @all_users=@all_users_fn
      elsif params[:searchlastname]
        @all_users = User.all(:conditions=>['last_name LIKE ? and first_name LIKE ?', "%#{params[:searchlastname]}", "%#{params[:searchfirstname]}"]).map { |i| i.id }
      else
        @all_users=@all_users_fn
      end
    else
      @all_users=User.all.map { |i| i.id }
    end

    if params[:searchrole]=="All"
      @allroleids = Role.all(:conditions=>['id IN(?)', @allmy_roleids])
    elsif params[:searchrole]
      @allroleids = Role.find(:all, :conditions=>['id IN(?) and name LIKE ?', @allmy_roleids, "%#{params[:searchrole]}"])
    else
      @allroleids = Role.all(:conditions=>['id IN(?)', @allmy_roleids])
    end

    @all_role_ids = @allroleids.map { |i| i.id }
    @allplayers=Player.all(:conditions=>["game_id IN(?) and user_id IN(?) and role_id IN(?)", @allgames, @all_users, @all_role_ids])

    # Now you make the download document

    book=Spreadsheet::Workbook.new
    sheet1=book.create_worksheet :name=>'Master Sheet'
    @case_sheets=Array.new()
    @case_number=Array.new()
    @rowcount=Array.new()
    if @scorecard_cases=CaseStudy.all(:conditions=>['eval_type=? and id IN(?)', false, @my_student_cases_ids])
      @scorecard_cases.each_with_index do |scorecard_case, index|
        @case_sheets[index]=book.create_worksheet :name=>scorecard_case.name
        @case_number[index]=scorecard_case.id
        @rowcount[index]=0
        @allissues=Issue.all(:conditions=>['case_study_id=?', scorecard_case.id])
        @allissues.each_with_index do |issue, issue_index|
          @case_sheets[index][0, 0]="Serial Number"
          @case_sheets[index][0, issue_index+1]=issue.name
        end
      end
    end
    @count_cases=@scorecard_cases.count

    # Header Row Defined - Standard Fields

    sheet1[0, 0]="Serial Number"
    sheet1[0, 1]="Game Id"
    sheet1[0, 2]="First Name"
    sheet1[0, 3]="Last Name"
    sheet1[0, 4]="Student Group Name"
    sheet1[0, 5]="Exercise"
    sheet1[0, 6]="Role"

    # Header Row Defined - Planning Document Fields

    sheet1[0, 7]="BATNA"
    sheet1[0, 8]="Reservation Price"
    sheet1[0, 9]="Target Price"

    # Header Row Defined - Result Fields

    sheet1[0, 10]="Agreement Status"
    sheet1[0, 11]="Case Type"
    sheet1[0, 12]="Agreement Value"
    sheet1[0, 13]="Opening Offer"
    sheet1[0, 14]="Total Score"


    @allplayers.each_with_index do |player, index|
      sheet1[index+1, 0] = index+1
      sheet1[index+1, 1] = player.game_id
      sheet1[index+1, 2] = player.user.first_name
      sheet1[index+1, 3] = player.user.last_name
      sheet1[index+1, 4] = player.game.student_group.name
      sheet1[index+1, 5] = CaseStudy.find(Game.find(player.game_id).case_study_id).name
      sheet1[index+1, 6] = Role.find(player.role_id).name

      if @p1=Planq.first(:conditions=>['player_id=? and name=?', player.id, "BATNA"])
        sheet1[index+1, 7] = @p1.value
      else
        sheet1[index+1, 7] =""
      end
      if @p2=Planq.first(:conditions=>['player_id=? and name=?', player.id, "Reservation Price"])
        sheet1[index+1, 8] = @p2.value
      else
        sheet1[index+1, 8] =""
      end
      if @p3=Planq.first(:conditions=>['player_id=? and name=?', player.id, "Target Price"])
        sheet1[index+1, 9] = @p3.value
      else
        sheet1[index+1, 9] =""
      end
      if Game.find(player.game_id).agreement_status
        sheet1[index+1, 10] = "All Agreed"
      else
        sheet1[index+1, 10] = "No Agreement"
      end
      if CaseStudy.find(player.game.case_study_id).eval_type
        sheet1[index+1, 11] = "Offer Based"
      else
        sheet1[index+1, 11] = "Scorecard Based"
      end
      if @ag_value=GameData.first(:conditions=>['game_id=? and data_is=?', player.game_id, "Agreement Value"])
        sheet1[index+1, 12] = @ag_value.value
      else
        sheet1[index+1, 12] = "NA"
      end
      if @oo_value=GameData.first(:conditions=>['game_id=? and data_of=? and data_is=?', player.game_id, Role.find(player.role_id).name, "Opening Offer"])
        sheet1[index+1, 13] = @oo_value.value
      else
        sheet1[index+1, 13] = "NA"
      end
      if @ts_value=GameData.first(:conditions=>['game_id=? and data_of=? and data_is=?', player.game_id, Role.find(player.role_id).name, "Total Score"])
        sheet1[index+1, 14] = @ts_value.value
      else
        sheet1[index+1, 14] = "NA"
      end
      if !CaseStudy.find(player.game.case_study_id).eval_type
        @allissues=Issue.all(:conditions=>['case_study_id=?', player.game.case_study_id])
        @count_cases.times do |case_index|
          if @case_number[case_index]==player.game.case_study_id
            @case_sheets[case_index][@rowcount[case_index]+1, 0]= @rowcount[case_index]+1
            @allissues.each_with_index do |issue, issue_index|
              @case_sheets[case_index][@rowcount[case_index]+1, issue_index+1]=IssueOption.find(PlayerScorecard.first(:conditions=>['player_id=? and issue_id=?', player.id, issue.id]).issue_option_id).option
            end
            @rowcount[case_index]+=1
          end
        end
      end

    end

    @filename=params[:filename]
    book.write "/root/sample/Dialogue1.0/public/reports/#{@filename}"


  end

  def student_data_view
    @active_game=Game.find(params[:active_game])
    @player=Player.find(params[:active_player])
  end

  def agreed
    @active_game=Game.find(params[:active_game])
    @player=Player.find(:first, :conditions => ['user_id=? and game_id=?', current_user.id, @active_game.id])
  end

  def close_game
    @active_game = Game.find(params[:active_game])
    @active_game.agreement_status = params[:agreement_status]
    @active_game.save!
    if @active_game.agreement_status == true
      redirect_to end_negotiation_path(:active_game=>@active_game.id, :check_form=>"true")
    else
      @game_data=GameData.new
      @game_data.game_id=@active_game.id
      @game_data.data_of="Game"
      @game_data.data_is="Agreement Status"
      @game_data.value=(@active_game.agreement_status ? "All agreed" : "No Agreement")
      @game_data.save
      redirect_to root_path(:check_form=>"true")
    end
  end

  def end_negotiation
    @active_game=Game.find(params[:active_game])
    @allissues=Issue.all(:conditions=>['case_study_id=?', @active_game.case_study_id])
    @allplayers=Player.all(:conditions=>['game_id=?', @active_game.id])
    @player=Player.find(:first, :conditions=>["user_id=? and game_id=?", current_user.id, @active_game.id])
    @option_values=Array.new

    @player_scorecards = PlayerScorecard.all(:conditions=>['player_id=?', @player.id])
  end

  def end_negotiation_update
    @active_game=Game.find(params[:active_game])
    @player=Player.find(:first, :conditions=>["user_id=? and game_id=?", current_user.id, @active_game.id])

    PlayerScorecard.all(:conditions=>['player_id=?', @player.id]).each do |scorecard|
      scorecard.destroy
    end

    @player_scorecards=params[:player_scorecards].values.collect { |player_scorecard| PlayerScorecard.new(player_scorecard) }

    if @player_scorecards.all?(&:valid?)
      @player_scorecards.each do |player_scorecard|
        if !@active_game.case_study.eval_type
          player_scorecard.value=OptionValue.find(:first, :conditions=>['issue_option_id=? and role_id=?', player_scorecard.issue_option_id, @player.role_id]).value
        end
        unless PlayerScorecard.first(:conditions=>['player_id=? and issue_id=? and value=?', player_scorecard.player_id, player_scorecard.issue_id, player_scorecard.value])
          player_scorecard.save!
        end
      end

      @players_in_the_game=Player.all(:conditions=>['game_id=?', @active_game.id])
      @all_issues=Issue.all(:conditions=>['case_study_id=?', @active_game.case_study.id])
      @active_game.status=false
      @all_issues.each do |issue|
        @base_scorecard=PlayerScorecard.find(:first, :conditions=>['issue_id=? and player_id in (?)', issue.id, @players_in_the_game])
        @players_in_the_game.each do |player|
          @comparative_scorecard=PlayerScorecard.find(:first, :conditions=>['issue_id=? and player_id=?', issue.id, player.id])

          if @active_game.case_study.eval_type
            if !(@comparative_scorecard.value==@base_scorecard.value)
              @active_game.status = true
            end
          else
            if !(@comparative_scorecard.issue_option_id==@base_scorecard.issue_option_id)
              @active_game.status = true
            end
          end

        end

      end

      if !@active_game.status
        @game_data=GameData.new
        @game_data.game_id=@active_game.id
        @game_data.data_of="Game"
        @game_data.data_is="Agreement Status"
        @game_data.value=(@active_game.agreement_status ? "All agreed" : "No Agreement")
        @game_data.save

        if @active_game.case_study.eval_type
          @game_data=GameData.new
          @game_data.game_id=@active_game.id
          @game_data.data_of="Game"
          @game_data.data_is="Agreement Value"
          @game_data.value=Offer.last(:conditions=>['game_id=?', @active_game.id]).value
          @game_data.save
        end

        @players_in_the_game.each do |player|
          if @active_game.case_study.eval_type
            @game_data=GameData.new
            @game_data.game_id=@active_game.id
            @game_data.data_of=player.role.name
            @game_data.data_is="Opening Offer"
            @game_data.value=Offer.first(:conditions=>['offerer=? and value>?', player.id, 0], :order=>"created_at ASC").value

          else

            @issues=Issue.all(:conditions=>['case_study_id=?', @active_game.case_study_id])
            @total_weight=0
            @total_score=0
            for issue in @issues
              @total_weight+=issue.weightage
            end
            for issue in @issues
              @player_scorecard=PlayerScorecard.first(:conditions=>['player_id=? and issue_id=?', player.id, issue.id])
              @total_score+=(issue.weightage * @player_scorecard.value.to_i)
            end
            @game_data=GameData.new
            @game_data.game_id=@active_game.id
            @game_data.data_of=player.role.name
            @game_data.data_is="Total Score"
            @game_data.value=(@total_score.to_f/@total_weight.to_f).to_i
          end
          @game_data.save
        end

      end
      @active_game.save
      if @active_game.status
        redirect_to :action=>'agreement_mismatch', :active_game=>@active_game.id, :active_player=>@player.id, :check_form=>"true"
      else
        redirect_to :action=>'game_over', :active_game=>@active_game.id, :active_player=>@player.id, :check_form=>"true"
      end
    else
      redirect_to root_path(:active_game=>@active_game.id, :active_player=>@player.id, :check_form=>"true")
    end
  end

  def game_over
    @active_game=Game.find(params[:active_game])
  end

  def agreement_mismatch
    @active_game=Game.find(params[:active_game])
  end


  #this is the method to download emails
  def download_email

    @active_game=Game.find(params[:active_game])
    @player=Player.find(params[:active_player])
    @game=Game.find(params[:gid])
    @players=@game.players

    @player_ids= Array.new
    @recipient =Array.new
    @recipient_ids=Array.new

    @players.each do |p|
      @player_ids << p.id
    end
    i=0
    @messages=Message.find(:all, :conditions => ["author_id IN (?)", @player_ids])

    @recipients =Array.new(@messages.count) { Array.new(@players.count) }
    @messages.each do |m|

      @recipient=Player.find(:all, :conditions => ["id IN (?)", m.recipients])
      @recipient.each do |r|
        @recipients[i] << Player.find(:first, :conditions=>['user_id=? and game_id=?', r.user_id, @game.id]).role.name
        @recipients[i].delete_if { |j| j==nil }

      end

      i=i+1

    end
    # @recipients.uniq!
    @names=Array.new
    @to=Array.new
    @messages.each do |m|
      if fromplayer=Player.find(:first, :conditions=>['user_id=? and game_id=?', m.author_id, @game.id])
        @names << fromplayer.role.name
      end
    end
    send_data(render_to_string, :filename => "download_email.html", :type => "text/html")


  end


  def student_data_options

    @active_game=Game.find(params[:active_game])
    @player=Player.find(params[:active_player])
    if current_user.educator
      @current_player=@player
    else
      @current_player=Player.find_by_user_id(current_user.id)
    end
    @players=@active_game.players
    render :layout=> "datastats_menu"

  end

  def general_statistics
    @active_game=Game.find(params[:active_game])
    @student_group=StudentGroup.find(Game.find(params[:active_game]).student_group_id)
    @game_datas=Array.new
    @scores=Array.new
    @agreement_values=Array.new

    @scorelist=0
    @agreementlist=0
    @min_score=0
    @max_score=0
    @min_agreement_value=0
    @max_agreement_value=0
    @avg_score=0
    @avg_agreement_value=0
    flag=0

    @games=@student_group.games
    @games.each do |game|

      flag=0
      @game_datas=GameData.find_all_by_game_id(game.id)
      @game_datas.each do |game_data|

        if (game_data.data_is == "Total Score")
          @scores << game_data.value
          #if (flag==0)
            @scorelist=@scorelist+1
            #flag=1
          #end
        elsif (game_data.data_is == "Agreement Value")

          @agreement_values << game_data.value
          #if (flag==0)
            @agreementlist=@agreementlist+1
            #flag=1
          #end

        end
      end
    end


    tmp=0
    @tmp1=0
    @min_score=@scores[0]
    @max_score=@scores[0]
    @scores.each do |score|
      if (@min_score > score)
        @min_score=score

      end

      if (@max_score < score)
        @max_score=score
      end
      tmp=tmp.to_i+score.to_i

    end
    if (@scorelist > 0)
      @avg_score=tmp/@scorelist
    else
      @avg_score=0
    end
    tmp=0

    @agreement_values.each do |value|
      if (@min_agreement_value.to_i > value.to_i)
        @min_agreement_value=value

      end

      if (@max_agreement_value.to_i < value.to_i)
        @max_agreement_value=value
      end
      tmp=tmp+value.to_i

    end
    if (@agreementlist > 0)
      @avg_agreement_value=tmp/@agreementlist.to_f
    else
      @avg_agreement_value=0
    end

  end

end
