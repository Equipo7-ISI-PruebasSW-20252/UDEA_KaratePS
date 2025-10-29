@parabank_billpay
Feature: Pagos de facturas en Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def val_accountId = 12345
    * def val_amount = 9999999
    * def val_smallAmount = 50
    * def val_invalidAccount = 99999

  Scenario: Pago fallido por saldo insuficiente
    Given path 'billpay'
    And param accountId = val_accountId
    And param amount = val_amount
    And request
    """
    {
      "name": "John Demo",
      "address": {
        "street": "Calle 123",
        "city": "Medellin",
        "state": "Antioquia",
        "zipCode": "050001"
      },
      "phoneNumber": "3001234567",
      "accountNumber": 12345
    }
    """
    When method POST
    Then status 400 || status 422
    * print 'Pago fallido (saldo insuficiente):', response


  Scenario: Pago exitoso con monto válido
    Given path 'billpay'
    And param accountId = val_accountId
    And param amount = val_smallAmount
    And request
    """
    {
      "name": "Maria Perez",
      "address": {
        "street": "Cra 45 #10-20",
        "city": "Bogota",
        "state": "Cundinamarca",
        "zipCode": "110111"
      },
      "phoneNumber": "3104567890",
      "accountNumber": 12456
    }
    """
    When method POST
    Then status 200
    * print 'Pago exitoso:', response



