require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'belongs to user' do
    friendship = Friendship.reflect_on_association(:user)
    expect(friendship.class).to be(ActiveRecord::Reflection::BelongsToReflection)
  end
end
