class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:format])
    @friendship = Friendship.create(user_id: current_user.id, friend_id: params[:format])
    redirect_back(fallback_location: root_path)
  end

  def update
    friendship = Friendship.record(current_user.id, params[:format])
    friendship.update(confirmed: true)
    Friendship.create(user_id: friendship.friend_id, friend_id: friendship.user_id, confirmed: true)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    friendship_delete = Friendship.find(params[:format])
    friendship_pair = Friendship.where("user_id = ? AND friend_id = ?", friendship_delete.friend_id, friendship_delete.user_id).first
    friendship_pair.destroy unless friendship_pair.nil?
    friendship_delete.destroy
    redirect_back(fallback_location: root_path)
  end
end
