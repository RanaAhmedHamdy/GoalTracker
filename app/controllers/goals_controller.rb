class GoalsController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_user
  
  def achieved_goals
    @goals = Goal.where(:user_id => @user.id, :achieved => true)
  end

  def index
    @goals = Goal.where(:user_id => @user.id, :achieved => false)
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new({:title => "", :user_id => session['user_id']})
  end

  def create
    # instantiate a new obj
    @goal = Goal.new(goal_params)
    # save the object
    if @goal.save
      # if save succeeds, redirect to index action
      #flash[:notice] = "Goal created successfully"
      redirect_to(:action => 'index', :user_id => @user.id)
    else
      # if save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    # find obj
    @goal = Goal.find(params[:id])
    # update the object
    if @goal.update_attributes(goal_params)
      # if update succeeds, redirect to index action
      #flash[:notice] = "Goal updated successfully"
      redirect_to(:action => 'show', :id => @goal.id)
    else
      # if update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def complete_goal
    @goal = Goal.find(params[:id])
  end

  def update_complete_goal
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params.require(:goal).permit(:achieved, :user_id))
      # if update succeeds, redirect to index action
      flash[:notice] = "Wow! you successfully achieved this goal"
      redirect_to(:action => 'index', :id => @goal.id)
    else
      # if update fails, redisplay the form so user can fix problems
      render('complete_goal')
    end
  end

  def delete
    @goal = Goal.find(params[:id])
  end

  def destroy
    goal = Goal.find(params[:id]).destroy

    flash[:notice] = "Goal '#{goal.title}' destroyed successfully"
    redirect_to(:action => 'index', :user_id => @user.id)
  end

  private
    def goal_params
      #raises an error if :subject not present
      #allow listed attributes to be mass-assigned
      params.require(:goal).permit(:title, :description, :start_date, :end_date, :user_id)
    end

    def find_user
      if session['user_id']
        @user = User.find(session['user_id'].to_i)
      end
    end
end
