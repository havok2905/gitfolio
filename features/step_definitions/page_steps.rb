When /^I show the page$/ do
  puts body
end

When /^I visit the homepage$/ do
  visit '/'
end

When /^I visit the user admin page$/ do
  visit users_path
end

When(/^I visit the launch page$/) do
  visit authenticated_root_path
end

When(/^I visit the profile edit page$/) do
  @user.reload
  visit edit_profile_path(@user.profile)
end

When(/^I visit my profile page$/) do
  @user.reload
  visit profile_path(@user.profile)
end

When(/^I visit my profile page while not logged in$/) do
  visit profile_path(Profile.first)
end
