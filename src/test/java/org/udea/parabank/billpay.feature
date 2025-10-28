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
    Given path 'services/bank/billpay'
    * def body =
    """
    payee.name=#(val_payeeName)&
    payee.address.street=#(val_street)&
    payee.address.city=#(val_city)&
    payee.address.state=#(val_state)&
    payee.address.zipCode=#(val_zip)&
    payee.phoneNumber=#(val_phone)&
    payee.accountNumber=#(val_accountNumber)&
    verifyAccount=#(val_verifyAccount)&
    amount=#(val_amount)&
    fromAccountId=#(val_fromAccount)
    """
    And request body
    When method POST
    Then assert responseStatus == 400 || responseStatus == 422
    * print 'Status:', responseStatus
    * print 'Response:', response
