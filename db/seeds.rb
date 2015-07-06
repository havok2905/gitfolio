user_a = User.create({
  email: 'foo@foo.foo',
  password: 'password',
  password_confirmation: 'password',
  role: 0 # Admin user
})

user_b = User.create({
  email: 'bar@bar.bar',
  password: 'password',
  password_confirmation: 'password',
  role: 1 # Admin user
})
