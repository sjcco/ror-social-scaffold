module UserHelper
  def owner?(user)
    if user == current_user
      true
    else
      false
    end
  end
end