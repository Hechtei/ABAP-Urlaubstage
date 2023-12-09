@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Textelement Mitarbeiter'

define view entity ZI_MJL_EMPLOYEE_Text
  as select from zmjl_employee
{

  key employee_uuid                                               as EmployeeUuid,
      employee_firstname                                          as FirstName,
      employee_lastname                                           as LastName,

      //Transient Data
      concat_with_space(employee_firstname, employee_lastname, 1) as Name

}
