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
      redirect_to child_anniversary_child_posts_path
    else
      render 'child_posts/new'
    end
  end

  def destroy
    @child_anniversary = ChildAnniversary.find(params[:child_anniversary_id])
    @child_post = ChildPost.find(params[:id])
    if current_user.admin? || current_user == @child_post.user
      @child_post.destroy
      flash[:success] = "記念日アニバを削除しました"
      redirect_to  root_url
    else
      flash[:danger] = "他人の記念日アニバは削除できません"
      redirect_to root_url
    end
  end

  def hashtag
    @user = current_user
    if params[:name].present?
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @child_posts = @hashtag.child_posts.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.child_posts.count}
    else
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.child_posts.count}
    end
  end

  private

  def child_post_params
    params.require(:child_post).permit(:content, :hashbody, :child_anniversary_id, :image, images: [], hashtag_ids: [])
  end
end
