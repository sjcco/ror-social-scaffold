class Friendship < ApplicationRecord
  belongs_to :user

  def self.record(id1, id2)
    case1 = Friendship.where(user_id: id1, friend_id: id2).all
    case2 = Friendship.where(user_id: id2, friend_id: id1).all
    if case1.empty?
      case2.first
    else
      case1.first
    end
  end

  def self.reacted?(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1).empty?
    case1 || case2
  end

  def self.requested(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2, confirmed: false).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1, confirmed: false).empty?
    case1 || case2
  end

  def self.confirmed_record?(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.find_friendship(id1, id2)
    if Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
      Friendship.where(user_id: id2, friend_id: id1, confirmed: true)[0].id
    else
      Friendship.where(user_id: id1, friend_id: id2, confirmed: true)[0].id
    end
  end
end
