FactoryGirl.define do
  factory :profile, class: Profile do
    first_name 'Eddy'
    last_name 'Dean'
    tagline 'foobar foo bat baz foobar foo'
    position 'developer'
    email 'foo@foo.foo'
    published false
  end
end
