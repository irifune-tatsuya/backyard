class EmployeesController < ApplicationController
  def index
    @employees = Employee.where(branch_id: params[:branch_id]).includes(:holidays)
  end
  
  def new
    @employee = Employee.new
  end

  def create
    Employee.create(employee_params)
    redirect_to root_path
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    employee = Employee.find(params[:id])
    employee.update(employee_params)
    redirect_to root_path
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    redirect_to root_path
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :employment_status, :hire_date, :branch_id)
  end

end