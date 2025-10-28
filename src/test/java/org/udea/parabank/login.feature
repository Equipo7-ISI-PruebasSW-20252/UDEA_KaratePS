@parabank_login
Feature: Login to Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Successful login with valid credentials
    Given path 'login'
    And param username = 'john'
    And param password = 'demo'
    When method GET
    Then status 200
    And match response ==
    """
    {
       id: '#number',
       firstName: '#string',
       lastName: '#string',
       address: {
            street: '#string',
            city: '#string',
            state: '#string',
            zipCode: '#string'
       },
       phoneNumber: '#string',
       ssn: '#string'
    }
    """
    And match response.firstName == 'John'

  Scenario: Failed login with invalid credentials
    Given path 'login'
    And param username = 'john'
    And param password = 'wrongpass'
    When method GET
    Then status 400
    And match response contains { error: '#string' }
