FactoryGirl.define do
  factory :repo, class: Repo do
    association :user, factory: :developer
    url 'https://github.com/havok2905/gitfolio'
    name 'gitfolio'
    description 'A github based portfolio site generator and developer hiring tool'
    whitelist false
    user_id 1
  end
end
