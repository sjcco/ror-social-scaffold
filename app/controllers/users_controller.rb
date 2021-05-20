class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    unless helpers.owner?(@user)
      unless current_user.friend_with?(@user)
        if current_user.friend_request_sent_to(@user)
          @route = '#'
          @button_message = 'request sent'
          @button_class = "btn btn-warning btn-lg"
        else
          @route = send_friend_request_path(@user)
          @button_message = 'request sent'
          @button_class = "btn btn-warning btn-lg"
        end      
      end
    end
  end
end
