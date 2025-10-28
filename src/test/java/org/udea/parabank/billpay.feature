@parabank_billpay
Feature: Pago fallido por saldo insuficiente en Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def val_fromAccountId = 12567
    * def val_payeeName = 'hola'
    * def val_payeeStreet = '123 Main St'
    * def val_payeeCity = 'Metropolis'
    * def val_payeeState = 'CA'
    * def val_payeeZip = '90210'
    * def val_payeePhone = '123-456-7890'
    * def val_accountNumber = 12345
    * def val_verifyAccount = 12345
    * def val_amount_ok = Math.round(Math.random() * 100)
    * def val_amount_insufficient = val_amount_ok + 100000

  Scenario: Pago fallido por saldo insuficiente
    Given path 'billpay'
    And form field payee.name = val_payeeName
    And form field payee.address.street = val_payeeStreet
    And form field payee.address.city = val_payeeCity
    And form field payee.address.state = val_payeeState
    And form field payee.address.zipCode = val_payeeZip
    And form field payee.phoneNumber = val_payeePhone
    And form field payee.accountNumber = val_accountNumber
    And form field verifyAccount = val_verifyAccount
    And form field amount = val_amount_insufficient
    And form field fromAccountId = val_fromAccountId
    When method POST
    Then status 400
    * print 'Respuesta de error (raw):', responseStatus, response
    And match response contains 'Insufficient'
