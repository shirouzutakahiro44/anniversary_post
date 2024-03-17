class ChildPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @child_posts = ChildPost.desc_order.paginate(page: params[:page], per_page: 5)
  end

  def show
    @child_post = ChildPost.find(params[:id])
    @comment = Comment.new
  end

  def new
    @child_anniversary = ChildAnniversary.find(params[:child_anniversary_id])
    @child_post = ChildPost.new
  end

  def edit
    @child_anniversary = ChildAnniversary.find(params[:child_anniversary_id])
    @child_post = ChildPost.find(params[:id]) 
  end

  def update
    @child_anniversary = ChildAnniversary.find(params[:child_anniversary_id])
    @child_post = ChildPost.find(params[:id])
    if @child_post.update(child_post_params)
      flash[:success] = "記念日アニバが更新されました"
      redirect_to child_anniversary_child_posts_path
    else
      render 'edit'
    end
  end

  def create
    @child_anniversary = ChildAnniversary.find(params[:child_anniversary_id])
    @child_post = @child_anniversary.build_child_post(child_post_params.merge(user: current_user))
    if @child_post.save
      flash[:success] = "登録が成功しました"
      redirect_to child_anniversary_path(@child_anniversary)
    else
      render 'child_posts/new'
    end
  end

  def destroy
    @child_anniversary = ChildAnniversary.find(params[:child_anniversary_id])
    @child_post = ChildPost.find(params[:id])
    if current_user.admin? || current_user?(@child_post.user)
      @child_post.destroy
      flash[:success] = "記念日アニバを削除しました"
      redirect_to  child_anniversary_child_posts_path
    else
      flash[:danger] = "他人の記念日アニバは削除できません"
      redirect_to root_url
    end
  end

  private

  def child_post_params
    params.require(:child_post).permit(:content, :child_anniversary_id, :image, images: [])
  end
end
