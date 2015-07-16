FactoryGirl.define do
  factory :repo_language, class: RepoLanguage do
    association :repo, factory: :repo
    name 'javascript'
    bytes 10_000_000
  end
end
