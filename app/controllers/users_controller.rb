class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :destroy, :following, :followers]
  
  def show
    @user = User.find(params[:id])
    @child_posts = @user.child_posts.desc_order.paginate(page: params[:page], per_page: 5)
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

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
