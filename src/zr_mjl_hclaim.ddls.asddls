@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Holiday claim'
define view entity ZR_MJL_HCLAIM
  as select from zmjl_hclaim

  //Associations for text elements
  association        to parent ZR_MJL_EMPLOYEE as _EMPLOYEE     on $projection.EmployeeUuid = _EMPLOYEE.EmployeeUuid
  association [1..1] to ZI_MJL_EMPLOYEE_Text   as _EMPLOYEETEXT on $projection.EmployeeUuid = _EMPLOYEETEXT.EmployeeUuid
{
  key hclaim_id          as HclaimId,
      @ObjectModel.text.element: [ 'EmployeeName' ]
      employee_uuid      as EmployeeUuid,
      hlcaim_year        as HlcaimYear,
      hlcaim_days        as HlcaimDays,
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,

      //Association
      _EMPLOYEE,

      //Transient Data
      _EMPLOYEETEXT.Name as EmployeeName
}
