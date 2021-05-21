class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @post = Post.new
    timeline_posts
    flash[:notice] = current_user.id
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
    end
  end

  private

  def timeline_posts
    ids = current_user.friends.map(&:id)  
    ids << current_user.id  
    @timeline_posts ||= Post.where(user_id: ids).all.ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
