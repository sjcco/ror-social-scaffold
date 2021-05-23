class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    select_button
  end

  # rubocop:disable  Metrics/MethodLength
  def select_button
    unless helpers.owner?(@user)
      if Friendship.reacted?(current_user.id, params[:id])
        @friendship = Friendship.record(current_user.id, params[:id])
        if current_user.friend_with?(@user)
          @show_hash = { route: destroy_friendship_path(@friendship), button_message: 'unfriend',
                         button_class: 'btn btn-danger btn-lg' }
        elsif Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
          @show_hash = { route: destroy_friendship_path(@friendship), button_message: 'cancel request',
                         button_class: 'btn btn-warning btn-lg' }
        else
          @show_hash = { route: accept_friend_request_path(@user), button_message: 'Accept',
                         button_class: 'btn btn-primary btn-lg' }
          @show_decline = true
          @frienship = Friendship.record(params[:id], current_user.id)
        end
      else
        @show_hash = { route: send_friend_request_path(@user), button_message: 'Send request',
                       button_class: 'btn btn-primary btn-lg' }
      end
    end
    @show_hash
  end
  # rubocop:enable  Metrics/MethodLength
end
