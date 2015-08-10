Then /^I should see users$/ do
  expect(page).to have_content('admin@example.com')
  expect(page).to have_content('developer@example.com')
end

Then /^I should be able to edit a user$/ do
  page.all('a', text: 'edit').last.click
  expect(page).to have_content('Edit User')

  fill_in 'user[nickname]', with: 'nickname changed'
  click_button 'Update User'

  step 'I visit the user admin page'
  expect(page).to have_content('nickname changed')
end

Then /^I should be able to view a user$/ do
  page.all('a', text: 'show').last.click
  expect(page).to have_content('Show User')
  expect(page).to have_content('developer@example.com')
  step 'I visit the user admin page'
end

@wip
Then /^I should be able to view a user profile$/ do
  #TODO More detailed profile factories need to be built for this.
end
