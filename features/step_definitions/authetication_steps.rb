When /^an admin user exists$/ do
  FactoryGirl.create :admin
end

When /^a developer user exists$/ do
  FactoryGirl.create :developer
end

When /^I fill in the login form as an admin user$/ do
  fill_in 'user[email]', with: 'admin@example.com'
  fill_in 'user[password]', with: 'password'
  click_button 'Log in'
end

When /^I fill in the login form as a developer user$/ do
  fill_in 'user[email]', with: 'developer@example.com'
  fill_in 'user[password]', with: 'password'
  click_button 'Log in'
end

When /^I am logged in as an admin user$/ do
  step 'I visit the homepage'
  step 'I fill in the login form as an admin user'
end

When /^I am logged in as a developer user$/ do
  step 'I visit the homepage'
  step 'I fill in the login form as a developer user'
end

Then /^I should see the login form$/ do
  expect(page).to have_css('input#user_email')
  expect(page).to have_css('input#user_password')
end

Then /^I should not see the login form$/ do
  expect(page).not_to have_css('input#user_email')
  expect(page).not_to have_css('input#user_password')
end
