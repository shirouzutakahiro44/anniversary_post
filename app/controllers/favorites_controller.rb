class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @child_post = ChildPost.find(params[:child_post_id])
    @user = @child_post.user
    current_user.favorite(@child_post)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @child_post = ChildPost.find(params[:child_post_id])
    current_user.favorites.find_by(child_post_id: @child_post.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
  
  def index
    @favorites = current_user.favorites
  end
end         