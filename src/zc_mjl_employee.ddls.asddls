@EndUserText.label: 'Employee'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_MJL_EMPLOYEE
  provider contract transactional_query
  as projection on ZR_MJL_EMPLOYEE
{
  key EmployeeUuid,
      EmployeeNr,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      EmployeeFirstname,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      EmployeeLastname,
      EmployeeEntrydate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      PlanedDays,
      UsedDays,
      UsableDays,


      //Associations:
      _HCLAIM   : redirected to composition child ZC_MJL_HCLAIM,
      _HREQUEST : redirected to composition child ZC_MJL_HREQUEST

}
