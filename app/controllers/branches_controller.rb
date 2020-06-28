class BranchesController < ApplicationController

  before_action :set_branch, only: [:edit, :update, :destroy]
  
  def index
  end

  def new
    @branch = Branch.new
  end

  def create
    branch = Branch.new(branch_params)
    if branch.save
      redirect_to root_path
    else
      @branch = Branch.new
      render :new
    end
  end

  def edit
  end

  def update
    if @branch.update(branch_params)
      redirect_to root_path
    else
      @branch = Branch.find(params[:id])
      render :edit
    end
  end

  def destroy
    if @branch.destroy
      redirect_to root_path
    end
  end
  
  private
  def branch_params
    params.require(:branch).permit(:name).merge(user_id: current_user.id)
  end

  def set_branch
    @branch = Branch.find(params[:id])
  end
end