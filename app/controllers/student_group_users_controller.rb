class StudentGroupUsersController < ApplicationController
  def index
    @student_group_users = StudentGroupUser.all
  end

  def show
    @student_group_user = StudentGroupUser.find(params[:id])
  end

def timepass
end
  def new
    @student_group = StudentGroup.find(params[:student_group])
    @allusers=User.find(:all,:conditions=>['facilitator_group_id=?',@student_group.facilitator_group.id],:order=>'first_name ASC')
    @student_group_users = Array.new(@allusers.count) { StudentGroupUser.new }
  end

  def create
    @student_group = StudentGroup.find(params[:student_group])
    @student_group_users = params[:student_group_users].values.collect { |student_group_user| StudentGroupUser.new(student_group_user) }
    @allusers=User.find(:all,:conditions=>['facilitator_group_id=?',@student_group.facilitator_group.id],:order=>'first_name ASC')
    @checked_userids=Array.new

    if @student_group_users.all?(&:valid?)
      @student_group_users.each do |sgu|
        if sgu.user_id
          if StudentGroupUser.find(:first,:conditions=>["student_group_id=? and user_id=?",sgu.student_group_id,sgu.user_id])
            @checked_userids<<sgu.user_id
          else
            @checked_userids<<sgu.user_id
            sgu.save!
          end
        end
      end
      @allusers.each do |user|
        if @exsgr=StudentGroupUser.find(:first,:conditions=>["student_group_id=? and user_id=?",@student_group.id,user.id])
          if !@checked_userids.include?(@exsgr.user_id)
            @exsgr.destroy
          end
        end
      end
      redirect_to @student_group
    else
      render :action => 'new'
    end
  end

  def edit
    @student_group_user = StudentGroupUser.find(params[:id])
  end

  def update
    @student_group_user = StudentGroupUser.find(params[:id])
    if @student_group_user.update_attributes(params[:student_group_user])
      flash[:notice] = "Successfully updated student group user."
      redirect_to @student_group_user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @student_group_user = StudentGroupUser.find(params[:id])
    @student_group_user.destroy
    flash[:notice] = "Successfully destroyed student group user."
    redirect_to student_group_users_url
  end
end

