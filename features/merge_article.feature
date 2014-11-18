Feature: Merge Articles
  As a blog administrator
  In order to remove duplicated articles
  I want to be able to merge articles with same topic

  Background: articles and users have been added to database

    Given the blog is set up
    Given the following users exist
    	| profile_id	| login		| name 			| password	| email				| state		|
    	| 2				| user_1	| User1			| 111222333	| user1@example.com	| active	|
    	| 3				| user_2	| User2			| 1234567	| user2@example.com	| active	|

    Given the following articles exist
    	| id | title | author | user_id | body   | allow_comments | published | published_at  	    |
    	| 3  | Art_1 | user_1 | 2 	    | Cont_1 | true           | true	  | 2014-16-11 20:30:00 |
    	| 4  | Art_2 | user_2 | 3 	    | Cont_2 | true           | true	  | 2014-17-11 21:30:00 |

    Given the following comments exist
    	| id | type | author | body  | article_id | user_id | created_at 		  |
    	| 1  | Comm | user_1 | Comm1 | 3          | 2       | 2014-16-11 20:31:00 |
    	| 2  | Comm | user_1 | Comm2 | 4          | 2       | 2014-17-11 21:31:00 |

  Scenario: A non-admin cannot merge articles
  	Given I am logged in as "user_1" with pass "111222333"
  	And I am on the Edit Page of Article with id 3
  	Then I should not see "Merge Articles"

  Scenario: An admin can merge articles
  	Given I am logged in as "admin" with pass "aaaaaaaa"
  	And I am on the Edit Page of Article with id 3
  	Then I should see "Merge Articles"
  	When I fill in "merge_with" with "4"
  	And I press "Merge"
  	Then I should be on the admin content page
  	And I should see "Articles successfully merged!"

  Scenario: The merged articles should contain the text of both previous articles
  	Given the articles with ids "3" and "4" were merged
  	And I am on the home page
  	Then I should see "Art_1"
  	When I follow "Art_1"
  	Then I should see "Cont_1"
  	And I should see "Cont_2"

  Scenario: The merged article should have on author (either one of the originals)
  	Given the articles with ids "3" and "4" were merged
  	Then "User1" should be author of 1 articles
  	And "User2" should be author of 0 articles

  Scenario: Comments on each of the two articles need to all be carried over
  	Given the articles with ids "3" and "4" were merged
  	And I am on the home page
  	Then I should see "Art_1"
  	When I follow "Art_1"
  	Then I should see "Comm1"
  	And I should see "Comm2"

  Scenario: The title should be either one of the merged articles
  	Given the articles with ids "3" and "4" were merged
  	And I am on the home page
  	Then I should see "Art_1"
  	And I should not see "Art_2"