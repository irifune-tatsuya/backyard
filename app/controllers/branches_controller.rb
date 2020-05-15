class BranchesController < ApplicationController
  
  def index
    @employees = Employee.where(branch_id: :nil)
  end

  def new
    @branch = Branch.new
  end

  def create
    Branch.create(branch_params)
    redirect_to root_path
  end

  def edit
    @branch = Branch.find(params[:id])
  end

  def update
    branch = Branch.find(params[:id])
    branch.update(branch_params)
    redirect_to root_path
  end

  def destroy
    branch = Branch.find(params[:id])
    branch.destroy
    redirect_to root_path
  end
  
  private
  def branch_params
    params.require(:branch).permit(:name).merge(user_id: current_user.id)
  end

end