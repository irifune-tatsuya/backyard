class HolidaysController < ApplicationController

  before_action :set_branch, only: [:new]

  def index
    @holidays = Holiday.all.includes(:employee)
  end

  def new
    @holiday = Holiday.new
  end

  def create
    holiday = Holiday.new(holiday_params)
    if holiday.save
      redirect_to root_path
    else
      @holiday = Holiday.new
      set_branch
      render :new
    end
  end

  def destroy
    holiday = Holiday.find(params[:id])
    holiday.destroy
    redirect_to holidays_path
  end

  private
  def holiday_params
    params.require(:holiday).permit(:add_day, :delete_day, :reason, :registration_date,:employee_id).merge(user_id: current_user.id)
  end

  def set_branch
    @branch = Branch.find(params[:branch_id])
  end
end
