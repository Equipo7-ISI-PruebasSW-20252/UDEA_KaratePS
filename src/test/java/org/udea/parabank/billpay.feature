@parabank_billpay
Feature: Pago fallido por saldo insuficiente en Parabank (API JSON)

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
      "name": "Juan Prueba",
      "address": {
        "street": "Calle 123",
        "city": "Medellin",
        "state": "Antioquia",
        "zipCode": "050001"
      },
      "phoneNumber": "3001234567",
      "accountNumber": "777"
    }
    """
    When method POST
    Then assert responseStatus == 400 || responseStatus == 422
    * print 'Status:', responseStatus
    * print 'Response:', response
