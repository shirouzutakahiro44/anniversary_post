class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = current_user.notifications.includes(child_post: [:child_anniversary, :user])
    current_user.update_attribute(:notification, false)
  end
end
