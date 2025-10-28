@Parabank_billpay
Feature: billpay

  Background:
    * url 'https://parabank.parasoft.com/parabank/services/bank'
    * header Content-Type = 'application/x-www-form-urlencoded'

  Scenario: Simular pago con monto mayor al saldo disponible
    Given path 'billpay'
    And form field payee.name = 'hola'
    And form field payee.address.street = '123 Main St'
    And form field payee.address.city = 'Metropolis'
    And form field payee.address.state = 'CA'
    And form field payee.address.zipCode = '90210'
    And form field payee.phoneNumber = '123-456-7890'
    And form field payee.accountNumber = '12345'
    And form field verifyAccount = '12345'
    And form field amount = '777'
    And form field fromAccountId = '12567'
    When method post
    Then status 400 || status 422
    And match response contains 'Insufficient funds'

