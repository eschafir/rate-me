Feature: As a speaker I want to delete events to take out them from the system
	
	Scenario: Successful removal of one event

	          Given the user "esteban" exists
	          Given the "event 3" of "esteban" exists for "2012/10/10"
	          And I am in the event list page
	          When I press "Delete" 
	          Then I should see "The event was deleted"
