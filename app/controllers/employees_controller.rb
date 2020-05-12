class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
  end

  def create
    Employee.create(employee_params)
    redirect_to root_path
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :employment_status, :hire_date, :branch_id)
  end

end