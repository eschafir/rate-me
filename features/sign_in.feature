Feature: As a speaker I want to create an account to log in

Scenario: Successful creation of an account (happy path)

	Given I am in the sign in page
	And I fill in "name" with "user0"
	And I fill in "username" with "user1_username"
	And I fill in "email" with "user0@unq.com"
	And I fill in "password" with "password"
	When I press "Continue" 
	Then I should see "main_page" page  

Scenario: Failed creation of the duplicated user account

	Given I am in the sign in page
	And The "user0" account already exists
	And I fill in "name" with "user0"
	And I fill in "username" with "user0_username"
	And I fill in "email" with "user0@unq.com"
	And I fill in "password" with "password"
	When I press "Continue" 
	Then I should see "The username already exists"
