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
      redirect_to root_path, notice: :'支社の登録が完了しました'
    else
      @branch = Branch.new
      flash.now[:alert] = '登録できませんでした すべての項目を記入して下さい'
      render :new
    end
  end

  def edit
  end

  def update
    if @branch.update(branch_params)
      redirect_to root_path, notice: :'支社情報の更新が完了しました'
    else
      set_branch
      flash.now[:alert] = '更新できませんでした すべての項目を記入して下さい'
      render :edit
    end
  end

  def destroy
    if @branch.destroy
      redirect_to root_path, notice: :'支社を削除しました'
    else
      set_branch
      flash.now[:alert] = '支社の削除に失敗しました'
      render :edit
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