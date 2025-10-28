@parabank_consulta_estados
Feature: Consulta de cuentas en Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def val_customerId = 12212  # ID por defecto del usuario John

  Scenario: Consulta exitosa para un customerId existente
    Given path 'services', 'bank', 'customers', val_customerId, 'accounts'
    When method GET
    Then status 200
    And match header Content-Type contains 'application/json'
    * print 'La información de las cuentas es:'
    * print response
    # Validar que haya al menos una cuenta
    And assert response.length > 0
    # Validar estructura de cada cuenta
    And match each response ==
    """
    {
      id: '#number',
      customerId: '#number',
      type: '#string',
      balance: '#number'
    }
    """
    # Validar que el customerId sea consistente
    And match each response.customerId == val_customerId


  Scenario Outline: Consulta fallida para un customerId inexistente
    Given path 'services', 'bank', 'customers', <customerId>, 'accounts'
    When method GET
    Then status 404
    * print 'Respuesta de error:', response
    And match response contains 'Could not find customer #' + <customerId>

    Examples:
      | customerId |
      | 22222      |
      | 1234       |
      | 55         |
