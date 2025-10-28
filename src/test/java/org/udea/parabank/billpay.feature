@Parabank_billpay
Feature: Pago fallido por saldo insuficiente

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'

  Scenario: Intentar pago con monto mayor al saldo
    Given path 'billpay'
    And request
      """
      {
        "accountId": 12345,
        "amount": 9999999,
        "payeeName": "Utility Company",
        "payeeAddressStreet": "123 Main St",
        "payeeAddressCity": "Metropolis",
        "payeeAddressState": "CA",
        "payeeAddressZipCode": "90210",
        "payeePhoneNumber": "123-456-7890"
      }
      """
    When method post
    Then status 400 || status 422
    And match response contains 'Insufficient funds'
