class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 12)
    end
  end

  def about
  end

  def terms
  end
end
