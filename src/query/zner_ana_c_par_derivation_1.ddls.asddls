/*
The difference of this query view to the query view ZNER_ANA_C_PAR_DERIVATION is, that the parameter
P_FirstDayOfMonth is not hidden. Therefore, the derivation is only performed before the prompts are displayed and the prompt is prefilled with the result of the derivation.
For performing the derivation the default value of P_FlightDate is used.
If the user overwrites the result, the derivation is not performed again afterwards
*/
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'characteristic structure'
@ObjectModel: {
  supportedCapabilities: [ #ANALYTICAL_QUERY ],
  modelingPattern: #ANALYTICAL_QUERY
}
define transient view entity ZNER_ANA_C_PAR_DERIVATION_1
  provider contract analytical_query
  with parameters
    @AnalyticsDetails.variable.defaultValue: '20240909'
    P_FlightDate : zner_flight_date,
    @Consumption.derivation: {
      lookupEntity: 'I_CalendarDate',
      resultElement: 'FirstDayOfMonthDate',
      binding: [
        { targetElement: 'CalendarDate' , type: #PARAMETER , value: 'P_FlightDate' }
      ]  
    }
    @EndUserText.label: 'First Day'
    P_FirstDayOfMonth : zner_flight_date

  as projection on ZNER_ANA_I_FlightCube
{  
   @AnalyticsDetails.query: { axis: #ROWS, totals: #SHOW }
   FlightDate,
   MaximumSeats
}
where FlightDate >= $parameters.P_FirstDayOfMonth
  and FlightDate <= $parameters.P_FlightDate
