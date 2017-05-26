class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.create(goal_params)

    if @goal.save
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:errors] = @goals.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :user_id)
  end
end
