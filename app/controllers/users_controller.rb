class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      flash[:success] = "ユーザーの削除に成功しました"
      redirect_to user_path
    elsif current_user?(@user)
      @user.destroy
      flash[:success] = "ユーザーの削除に成功しました"
      redirect_to user_path
    else
      flash[:danger] = "他人のアカウントは削除できません"
      redirect_to root_path
    end
  end

end
