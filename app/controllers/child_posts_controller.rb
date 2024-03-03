class ChildPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @child_posts = ChildPost.desc_order
  end

  def show
    @user = User.find(params[:id])
    @child_posts = @user.child_posts.paginate(page: params[:page], per_page: 5)
  end

  def new
    @child_anniversary = ChildAnniversary.find(params[:child_anniversary_id])
    @child_post = ChildPost.new
  end

  def edit
  end

  def create
    @child_post = current_user.child_posts.build(child_post_params)
    if @child_post.save
      flash[:success] = "登録が成功しました"
      redirect_to root_path
    else
      render 'child_posts/new'
    end
  end

  def update
  end

  def destroy
  end

  private

  def child_post_params
    params.require(:child_post).permit(:content, :image, :child_anniversary_id)
  end
end
