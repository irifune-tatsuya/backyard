class HolidaysController < ApplicationController
  def index
    @holidays = Holiday.all.includes(:employee)
  end

  def new
    @holiday = Holiday.new
    @branch = params[:branch_id]
    branch = Branch.find(params[:branch_id])
    @branch_name = branch.name
  end

  def create
    Holiday.create(holiday_params)
    redirect_to root_path
  end

  private
  def holiday_params
    params.require(:holiday).permit(:add_day, :delete_day, :reason, :employee_id).merge(user_id: current_user.id)
  end
end
