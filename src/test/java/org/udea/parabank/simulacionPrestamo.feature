@parabank_prestamo
Feature: Simulación de préstamo en Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def faker = new config.faker()
    * def val_customerId = 12212
    * def val_accountId = 13344
    * def val_amount = Math.round(Math.random() * 1000)
    * def val_downPayment = Math.round(Math.random() * 1000)

  Scenario: Solicitud de préstamo exitosa
    Given path 'requestLoan'
    And param customerId = val_customerId
    And param amount = val_amount
    And param downPayment = val_downPayment
    And param fromAccountId = val_accountId
    When method POST
    Then status 200
    * print 'Respuesta del préstamo:', response
    And match response ==
    """
    {
      responseDate: '#number',
      loanProviderName: '#string',
      approved: '#boolean',
      accountId: '#number'
    }
    """