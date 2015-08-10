Feature: Devise Authentication and OAuth

Scenario: Admin Authentication
  Given an admin user exists
  And I visit the homepage
  Then I should see the login form
  When I fill in the login form as an admin user
  Then I should not see the login form

Scenario: Developer Authentication
  Given a developer user exists
  And I visit the homepage
  Then I should see the login form
  When I fill in the login form as a developer user
  Then I should not see the login form
