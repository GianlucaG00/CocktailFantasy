Feature: Some User Stories 

Scenario: As an unregistered user I want to signin with email so that I can become a new drinker
    When I am on the CocktailFantasy home page
    When I follow "Drinker"
    And I follow "Registrati ora!"
    Then I should be on the Drinker registration page
    When I fill in "drinker_email" with "prova@prova.it"
    And I fill in "drinker_password" with "prova123"
    And I press "commit"
    Then I should be on the CocktailFantasy home page
    And I should see "Bentornato!"

Scenario: As an unregistered user I want to signin with email so that I can become a new Barman
    When I am on the CocktailFantasy home page
    When I follow "Barman"
    And I follow "Registrati ora!"
    Then I should be on the Barman registration page
    When I fill in "barman_name" with "test"
    And I fill in "barman_surname" with "test"
    And I fill in "barman_email" with "test@test.it"
    And I fill in "barman_password" with "prova123"
    And I press "commit"
    Then I should be on the CocktailFantasy home page
    And I should see "Bentornato!"

Scenario: As an unregistered user I want to contact the developer so that I can report any misuse of the application
    When I am on the CocktailFantasy home page
    Then I should see "Contatti Sviluppatore"


Scenario: As a Barman I want to add a bar so that I can populate the bar list
    Given I am a registered Barman as "prova4", "prova4", "prova4@prova4.it", "password"
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
    Given I am a registered Barman as "prova4", "prova4", "prova4@prova4.it", "password" and I have a Bar "Bar Prova", "Via della Prova", "Questa è una descrizione di prova", "0000000000"
    When a barman goes to the "/barmen/personalArea" page
    And I select "Bar Prova" from "select-bar"
    And I fill in "msg" with "Messaggio di prova"
    Then I should be on the barman personal area

Scenario: As a Barman I want to display the bars I own in my personal area so that I can access the bars I own
    Given I am a registered Barman as "prova4", "prova4", "prova4@prova4.it", "password" and I have a Bar "Bar Prova", "Via della Prova", "Questa è una descrizione di prova", "0000000000"
    When I go to the barman personal area
    Then I should see "Bar Prova"
    And I should see "Questa è una descrizione di prova"
    And I should see "Modifica"
    And I should see "Visualizza"
    And I should see "Elimina"

Scenario: As a Drinker I want to subscribe to a Bar going in my personal Area so that I can receive telegram notification for announcements on Bar I am interested in 
    Given a Bar "Bar Prova" of a Barman
    And I am a registered Drinker as "prova@prova.it", "prova123" correctly recognized in telegram
    When I go to the drinker personal area 
    Then I should be on the drinker personal area
    And I should see "Aggiungi iscrizioni"
    When I select "Bar Prova" from "select-bar"
    When I press "subscribe-btn"
    Then I should see "Bar Prova"

Scenario: As an unregistered user I want to filter the bar list by name so that I find a Bar quickly
    Given two Bars "Bar One" and "Bar Two" of a Barman 
    When I am on the CocktailFantasy home page
    Then I should see "Bar One"
    And I should see "Bar Two"
    When I fill in "search" with "One"
    And I press "Cerca"
    Then I should be on the Bar page 
    And I should see "Bar One"
    And I should not see "Bar Two"


Scenario: As a Barman I want to add a new cocktail in the menu of a Bar I own so that I can populate its menu
    Given I am a registered Barman as "prova4", "prova4", "prova4@prova4.it", "password" and I have a Bar "Bar Prova", "Via della Prova", "Questa è una descrizione di prova", "0000000000"
    When I go to the barman personal area
    Then I should see "Bar Prova"
    When I follow "Bar Prova"
    And I follow "add-cocktail"
    When I fill in "cocktail-name" with "Cocktail Prova"
    And I fill in "cocktail-preparation" with "Cocktail preparation"
    And I fill in "cocktail-ingredients" with "IngredientA,IngredientB"
    And I fill in "cocktail-price" with "12"
    And I press "Aggiungi"
    Then I should see "Il cocktail Cocktail Prova per il menù del Bar 'Bar Prova' è stato aggiunto con successo"



    


