When /^I show the page$/ do
  puts body
end

When /^I visit the homepage$/ do
  visit '/'
end

When /^I visit the user admin page$/ do
  visit users_path
end
