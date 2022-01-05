Feature: Student Details
  In this feature we are adding a new user and thier details

  Background: Steps
    * url 'http://localhost:3000'
    * header content-type = 'application/json'

  Scenario: Getting Student records using Get method
    Given path '/students/3'
    When method GET
    Then status 200
    And match response.firstname == 'amit'
    And print response

  Scenario: Creating Student Record using POST method
    Given path '/students'
    And request {"stream":"science","firstname":"Preeti","lastname":"khurana"}
    When method POST
    Then status 201
    And match $.firstname == 'Preeti'
    And match $.id == '#ignore'

  Scenario Outline: Creating Students by fetching data from csv
    Given path '/students'
    And request {stream:'<stream>',firstname:'<firstname>',lastname:'<lastname>'}
    When method POST
    Then status 201
    And match $.id == '#ignore'

    Examples: 
      | read('data.csv') |

  Scenario Outline: Modifying Student Record using PUT method
    Given path '/students/<id>'
    And request {stream:'<stream>',firstname:'<firstname>',lastname:'<lastname>'}
    When method PUT
    Then status 200
    And match $.firstname == '<ExpectedResult>'
    And match $.id == '#ignore'

    Examples: 
      | stream   | firstname | lastname | id | ExpectedResult |
      | arts     | amit      | sharma   |  3 | amit           |
      | Commerce | Akhil     | Mishra   |  5 | akhil          |
      | science  | akanksha  | gupta    |  7 | akanksha       |
