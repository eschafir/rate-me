Feature: As a speaker I want to delete events to take out them from the system
	
	Scenario: Successful removal of event

	          Given The "esteban" account already exists
	          Given the "event 1" exists for "2012-10-10"
	          Given I am on event list page
	          When I press "Delete" 
	          Then I should see "The event was deleted."
