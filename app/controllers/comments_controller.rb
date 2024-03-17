class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @child_post = ChildPost.find(params[:child_post_id])
    @user = @child_post.user
    @comment = @child_post.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@child_post.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"+ @comment.errors.full_messages.join(", ")
    end
    redirect_to request.referrer
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
end