Feature: Devise Authentication and OAuth

Scenario: Admin Authentication
  Given a admin user exists
  And I visit the homepage
  Then I should see the login form
  When I login as an admin user with password
  Then I should be on the welcome screen

Scenario: Github Authentication
  Given a developer user exists
  And I visit the homepage
  Then I should see the authenticate with Github button
  When I click the authenticate with Github button
  Then I should be forced to enter my Github credentials
  When I fill in my Github credentials and submit
  Then I should be on the welcome screen
