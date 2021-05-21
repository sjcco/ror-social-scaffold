module UserHelper
  def owner?(user)
    user == current_user
  end
end
