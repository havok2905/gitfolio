FactoryGirl.define do
  factory :developer, class: User do
    association :profile, factory: :profile
    role 1
    email 'developer@example.com'
    password 'password'
    password_confirmation 'password'
    nickname 'havok2905'
  end

  factory :admin, class: User do
    role 0
    email 'admin@example.com'
    password 'password'
    password_confirmation 'password'
    nickname 'havok2905'
  end
end
