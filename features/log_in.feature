Feature: As a speaker I want to Log in to use the application	

Scenario: Successful access to the application

        Given The username "user0_username" with password "password" exists
	Given I am in the log in page
	And I fill in "username" with "user0_username"
	And I fill in "password" with "password"
	When I press "Log in" 
	Then I should see "Hello" 

Scenario: Incorrect Password

        Given The username "user0_username" with password "password" exists
	Given I am in the log in page
	And I fill in "username" with "user0_username"
	And I fill in "password" with "wrong_password"
	When I press "Log in" 
	Then I should see "The password is incorrect"


Scenario: Incorrect Username

        Given The username "user0_username" with password "password" exists
	Given I am in the log in page
	And I fill in "username" with "wrong_user0_username"
	And I fill in "password" with "password"
	When I press "Log in" 
	Then I should see "The username doesnt exist"
