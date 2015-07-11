FactoryGirl.define do
  factory :repo, class: Repo do
    url 'https://github.com/havok2905/gitfolio'
    name 'gitfolio'
    description 'A github based portfolio site generator and developer hiring tool'
    whitelist false
  end
end
