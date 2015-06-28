user_a = User.create({
  email: 'foo@foo.foo',
  password: 'password',
  password_confirmation: 'password',
  role: 0 # Admin user
})

profile_a = Profile.create({
  first_name: 'Tony',
  last_name: 'Stark',
  tagline: 'Lorem Ipsum Dolor',
  position: 'Avenger',
  email: 'tony@example.com'
})

whitelist_a = Whitelist.create({
  user_id: user_a.id
})

repo = Repo.create({
  url: 'https://github.com/havok2905/gitfolio',
  description: '',
  name: 'gitfolio',
  user_id: user_a.id,
  whitelist_id: whitelist_a.id
})

user_b = User.create({
  email: 'bar@bar.bar',
  password: 'password',
  password_confirmation: 'password',
  role: 1 # Admin user
})

profile_b = Profile.create({
  first_name: 'Bruce',
  last_name: 'Banner',
  tagline: 'Lorem Ipsum Dolor',
  position: 'Avenger',
  email: 'bruce@example.com'
})
