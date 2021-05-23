FactoryBot.define do
  factory :user do
    email { 'example@test.com' }
    name { 'testing factory' }
    password { '12345678' }
  end
end
