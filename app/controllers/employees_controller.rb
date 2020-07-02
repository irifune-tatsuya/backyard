class EmployeesController < ApplicationController

  before_action :set_employee, only: [:edit, :update, :destroy]
  before_action :set_curent_user_branch, only: [:new, :create, :edit, :update]

  def index
    @employees = Employee.where(branch_id: params[:branch_id]).includes(:holidays)
  end
  
  def new
    @employee = Employee.new
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      redirect_to branch_employees_path(employee_params[:branch_id]), notice: :'社員の登録が完了しました'
    else
      @employee = Employee.new
      flash.now[:alert] = '登録できませんでした すべての項目を記入して下さい'
      render :new
    end
  end

  def edit
  end

  def update
    branch_id = @employee.branch_id
    if @employee.update(employee_params)
      redirect_to branch_employees_path(branch_id), notice: :'社員情報の更新が完了しました'
    else
      set_curent_user_branch
      set_employee
      flash.now[:alert] = '更新できませんでした すべての項目を記入して下さい'
      render :edit
    end
  end

  def destroy
    branch_id = @employee.branch_id
    if @employee.destroy
      redirect_to branch_employees_path(branch_id), notice: :'社員を削除しました'
    else
      redirect_to root_path, alert: :'社員の削除に失敗しました'
    end
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :employment_status, :hire_date, :branch_id)
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def set_curent_user_branch
    @branch = Branch.where(user_id: current_user)
  end
end