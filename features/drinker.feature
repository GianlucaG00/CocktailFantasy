Feature: features

Scenario: As a unregistered user I want to signin with email so that I can become a new drinker
    Given I am on the CocktailFantasy home page
    When I follow "Drinker"
    Then I should be on the Drinker login page
    When I fill in "drinker_email" with "prova@prova.it"
    And I fill in "drinker_password" with "prova123"
    And I press "commit"
    Then I should be on the CocktailFantasy home page
    And I should see "Bentornato!"

Scenario: As a Barman I want to add a bar so that I can populate the bar list
    Given a registered Barman as "prova4", "prova4", "prova4@prova4.it", "password"
    When I am on the CocktailFantasy home page
    And I follow "Aggiungi"
    Then I should be on the new Bar page
    When I fill in "bar_name" with "Bar Prova"
    And I fill in "bar_address" with "Via della Prova"
    And I fill in "bar_description" with "Questa è una descrizione di prova"
    And I fill in "bar_tel" with "0000000000"
    And I press "commit"
    And a barman goes to the "/bars" page
    Then I should see "Bar Prova"

Scenario: As a Barman I want to send a message to all the subscribers of a bar I own so that the interested users can be notified
    Given a registered Barman as "prova4", "prova4", "prova4@prova4.it", "password"
    When a barman goes to the "/barmen/personalArea" page
    And I select "Bar Prova" from "select-bar"
    And I fill in "msg" with "Messaggio di prova"
    Then I should be on the barman personal area

Scenario: As a Barman I want to display the bars I own in my personal area so that I can access the bars I own
    When The barman "prova@prova.it" has a bar
    And I go to the barman personal area
    Then I should see "BarTest"
    And I should see "Descrizione test"

Scenario: As a Drinker
    Given a registered Drinker as "prova@prova.it", "prova123"
    When I go to the drinker personal area 
    Then I should see "Aggiungi iscrizioni"
    When I select "Bar Prova" from "select-bar"
    Then I should see "Bar Prova"

Scenario: As an unregistered user I want to filter the bar list by name so that I can filter the bars by name
    Given I am on the CocktailFantasy home page
    When I fill in "search" with "Prova"
    Then I should see "Bar Prova"

Scenario:


    


