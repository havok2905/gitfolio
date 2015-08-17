When(/^I don't have repositories$/) do
  expect(@user.repos.count <= 0).to be(true)
end

When(/^I sync my repositories$/) do
  click_link 'Sync Repositories'
end

Then(/^I should be able to build a profile$/) do
  expect(page).to have_content('Build Your Profile')
end

When(/^I build a profile$/) do
  click_link 'Build Your Profile'
  step 'I fill in my profile information'
end

Then(/^I should be able to edit the profile$/) do
  expect(page).to have_content('Edit Profile')
end

When(/^I fill in my profile information$/) do
  fill_in 'profile[first_name]', with: 'Christopher'
  fill_in 'profile[last_name]', with: 'McLean'
  fill_in 'profile[email]', with: 'havok2905@gmail.com'
  fill_in 'profile[tagline]', with: 'I build software'
  fill_in 'profile[position]', with: 'software engineer'

  click_button 'Update Profile'
end

Then(/^I should be able to view my profile$/) do
  expect(page).to have_content('View Profile')
end

Then(/^I should not be able to view my profile$/) do
  expect(page.status_code).to eq(500)
end

When(/^I publish my profile$/) do
  click_link 'Publish Your Profile'
end

Then (/^I should see my public profile$/) do
  expect(page).to have_content 'Eddy Dean'
end
