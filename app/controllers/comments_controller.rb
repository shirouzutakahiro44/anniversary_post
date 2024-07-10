class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @child_post = ChildPost.find(params[:child_post_id])
    @user = @child_post.user
    @comment = @child_post.comments.build(user_id: current_user.id,
                                          content: params[:comment][:content])
    if !@child_post.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"

      if @user != current_user
        @user.notifications.create(child_post_id: @child_post.id, variety: 2,
                                   from_user_id: current_user.id,
                                   content: @comment.content) # コメントは通知種別2
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。" + @comment.errors.full_messages.join(", ")
    end
    redirect_to request.referrer
  end

  def edit
    @comment = Comment.find(params[:id])
    @child_post = @comment.child_post
    @child_anniversary = @child_post.child_anniversary
    unless @comment.user_id == current_user.id
      flash[:danger] = "他人のコメントは編集できません"
      redirect_to child_anniversary_child_post_path(@child_post.child_anniversary, @child_post)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @child_post = @comment.child_post
    @child_anniversary = @child_post.child_anniversary
    if @comment.update(comment_params)
      flash[:success] = "コメントが更新されました"
      redirect_to child_anniversary_child_post_path(@child_post.child_anniversary, @child_post)
    else
      redirect_to child_anniversary_child_posts_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @child_post = @comment.child_post
    @child_anniversary = @child_post.child_anniversary

    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to child_anniversary_child_post_path(@child_anniversary, @child_post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)  # :content は保存したいコメントの属性です
  end
end
