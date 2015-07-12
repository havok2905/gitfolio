FactoryGirl.define do
  factory :repo_language, class: RepoLanguage do
    association :repo, factory: :repo
    name 'javascript'
    bytes 10000000
  end
end
