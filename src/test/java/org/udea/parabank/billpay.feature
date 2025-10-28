@parabank_billpay
Feature: Pago fallido por saldo insuficiente en Parabank

  Background:
    * url baseUrl
    * header Accept = 'text/html'
    * header Content-Type = 'application/x-www-form-urlencoded'
    * def val_payeeName = 'Juan Prueba'
    * def val_street = 'Calle 123'
    * def val_city = 'Medellin'
    * def val_state = 'Antioquia'
    * def val_zip = '050001'
    * def val_phone = '3001234567'
    * def val_accountNumber = 777
    * def val_verifyAccount = 777
    * def val_fromAccount = 12345
    * def val_amount = 9999999

  Scenario: Pago fallido por saldo insuficiente
    Given path 'billpay'
    And param payee.name = val_payeeName
    And payee.address.street = val_street
    And payee.address.city = val_city
    And payee.address.state = val_state
    And payee.address.zipCode = val_zip
    And payee.phoneNumber = val_phone
    And payee.accountNumber = val_accountNumber
    And verifyAccount = val_verifyAccount
    And amount = val_amount
    And fromAccountId = val_fromAccount
    When method POST
        Then status 400
        * print 'Respuesta de error:', response
