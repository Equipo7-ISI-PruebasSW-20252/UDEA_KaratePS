@parabank_consulta_Estados
Feature: Consulta de cuenta en Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def val_customerId = 12212 //id por defecto para usuario John

  Scenario: Consulta exitosa para un customerId existente
    Given path 'customers'
    And path val_customer_id
    And path 'accounts'
    When method GET
    Then status 200
    * print 'La Información de la Cuenta es:'
    * print response
    And match each response ==
      """
      {
        "id": '#number',
        "customerId": '#number',
        "type": '#string',
        "balance": '#number'
        }
        """

      Scenario Outline: Consulta fallida para un curtomerId inexistente
        Given path 'customers'
        And path <customerId>
        And path 'accounts'
        When method GET
        Then status 400
        * print response
        And match response == 'Could not find customer #' + <customerId>
      Examples:
        |customerId     |
        |22222  |
        |1234   |
        |55     |
