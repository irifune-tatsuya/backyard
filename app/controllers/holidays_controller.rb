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
      redirect_to  branch_employees_path(params[:branch_id]), notice: :'有休登録が完了しました'
    else
      @holiday = Holiday.new
      set_branch
      flash.now[:alert] = '登録できませんでした すべての項目を記入して下さい'
      render :new
    end
  end

  def destroy
    holiday = Holiday.find(params[:id])
    if holiday.destroy
      redirect_to holidays_path, notice: :'有休情報を削除しました'
    else
      redirect_to holidays_path, alert: :'有休情報の削除に失敗しました'
    end
  end

  private
  def holiday_params
    params.require(:holiday).permit(:add_day, :delete_day, :reason, :registration_date,:employee_id).merge(user_id: current_user.id)
  end

  def set_branch
    @branch = Branch.find(params[:branch_id])
  end
end
