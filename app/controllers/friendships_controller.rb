class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:format])
    @friendship = Friendship.create(user_id: current_user.id, friend_id: params[:format])
    redirect_to @user
  end

  def update
    friendship = Friendship.record(current_user.id, params[:format])
    friendship.update(confirmed: true)
    redirect_back(fallback_location: root_path)
  end 
end