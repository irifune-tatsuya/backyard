class EmployeesController < ApplicationController

  before_action :set_employee, only: [:edit, :update, :destroy]
  before_action :set_curent_user_branch, only: [:new, :edit]

  def index
    @employees = Employee.where(branch_id: params[:branch_id]).includes(:holidays)
  end
  
  def new
    @employee = Employee.new
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      redirect_to root_path
    else
      @employee = Employee.new
      render :new
    end
  end

  def edit
  end

  def update
    branch_id = @employee.branch_id
    if @employee.update(employee_params)
      redirect_to branch_employees_path(branch_id)
    else
      set_curent_user_branch
      set_employee
      render :edit
    end
  end

  def destroy
    branch_id = @employee.branch_id
    if @employee.destroy
      redirect_to branch_employees_path(branch_id)
    else
      redirect_to root_path
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