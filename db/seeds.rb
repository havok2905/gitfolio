# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create({
  email: 'foo@foo.foo',
  password: 'password',
  password_confirmation: 'password',
  role: 0 # Admin user
})

user = User.create({
  email: 'bar@bar.bar',
  password: 'password',
  password_confirmation: 'password',
  role: 1 # Admin user
})

profile = Profile.create({
  first_name: 'Tony',
  last_name: 'Stark',
  tagline: 'Lorem Ipsum Dolor',
  position: 'Avenger',
  email: 'tony@example.com'
})

profile = Profile.create({
  first_name: 'Bruce',
  last_name: 'Banner',
  tagline: 'Lorem Ipsum Dolor',
  position: 'Avenger',
  email: 'bruce@example.com'
})
