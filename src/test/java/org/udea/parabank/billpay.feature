@parabank_billpay
Feature: billpay

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def val_accountId = 12345
    * def val_amount = 9999999

  Scenario: Pago fallido por saldo insuficiente
    Given path 'billpay'
    And param accountId = val_accountId
    And param amount = val_amount
    And request
    """
    {
      "name": "john demo",
      "address": {
        "street": "Calle 123",
        "city": "Medellin",
        "state": "Antioquia",
        "zipCode": "050001"
      },
      "phoneNumber": "3001234567",
      "accountNumber": "12345"
    }
    """
    When method POST
    Then status 400
    * print 'Respuesta de error:', response
