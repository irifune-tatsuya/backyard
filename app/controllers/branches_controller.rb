class BranchesController < ApplicationController
  
  def index
    @branch = Branch.all
  end

  def new
    @branch = Branch.new
  end

  def create
    Branch.create(branch_params)
    redirect_to root_path
  end
  
  private
  def branch_params
    params.require(:branch).permit(:name).merge(user_id: current_user.id)
  end

end