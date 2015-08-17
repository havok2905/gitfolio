Feature: User Administration and Management

@user_admin
Scenario: Admin can edit, view a user, and view a user's profile
  Given an admin user exists
  And a developer user exists
  And I am logged in as an admin user
  When I visit the user admin page
  Then I should see users
  And I should be able to edit a user
  And I should be able to view a user
  And I should be able to view a user profile
