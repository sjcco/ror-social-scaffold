class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :pending_frienships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    ids = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    User.where(id: ids)
  end

  def friendship_requests
    friendships_got_invited = Friendship.where(friend_id: id, confirmed: false).pluck(:user_id)
    User.where(id: friendships_got_invited)
  end

  def friend_with?(user)
    Friendship.where("user_id = ? AND friend_id = ? AND confirmed = ?", id, user.id, true).first
  end

  def friend_request_sent_to(user)
    Friendship.requested(id, user.id)
  end
end
