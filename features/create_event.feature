Feature: As a speaker I want to create an event in order to receive feedback
Scenario: Successful creation of an event

	Given I am on create event page
	And I fill in "name" with "talk about something"
     	And I fill in "date" with "2012-10-13"
	When I press "Create event"
	Then I should see "Event created"

