@EndUserText.label: 'Employee App 2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_MJL_EMPLOYEE_APP2
  provider contract transactional_query
  as projection on ZR_MJL_EMPLOYEE
{
  key EmployeeUuid,
      EmployeeNr,
      EmployeeFirstname,
      EmployeeLastname,
      EmployeeEntrydate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      //Associations
      _HREQUEST : redirected to composition child ZC_MJL_HREQUEST_APP2
}
