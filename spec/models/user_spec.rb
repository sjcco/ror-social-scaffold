require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name) }

  it 'should have many posts' do
    user = User.reflect_on_association(:posts)
    expect(user.macro).to eq(:has_many)
  end

  it 'should have many comments' do
    user = User.reflect_on_association(:comments)
    expect(user.macro).to eq(:has_many)
  end

  it 'should have many likes' do
    user = User.reflect_on_association(:likes)
    expect(user.macro).to eq(:has_many)
  end

  it 'should have many friendships' do
    user = User.reflect_on_association(:friendships)
    expect(user.macro).to eq(:has_many)
  end

  it 'should have many pending_friendships' do
    user = User.reflect_on_association(:pending_frienships)
    expect(user.macro).to eq(:has_many)
  end
end
