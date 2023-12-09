@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help Superior'

define view entity ZI_MJL_SuperiorVH as select from zmjl_employee
{
    key employee_uuid as EmployeeId,
    employee_firstname as EmployeeFirstname,
    employee_lastname as EmployeeLastname
    
    
}
