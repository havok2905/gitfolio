Feature: Profile Management

@profile
Scenario: Profile Onboarding Process
  Given a developer user exists with no profile
  And I am logged in as a developer user
  When I visit the launch page
  And I don't have repositories
  When I sync my repositories
  Then I should be able to build a profile
  When I build a profile
  Then I should be able to edit the profile
  When I visit the profile edit page
  And I fill in my profile information
  Then I should be able to view my profile

@profile @allow-rescue
Scenario: Profile Publishing
  Given a developer user exists
  When I visit my profile page while not logged in
  Then I should not be able to view my profile
  And I am logged in as a developer user
  When I visit the profile edit page
  And I publish my profile
  And I logout
  When I visit my profile page while not logged in
  Then I should see my public profile
