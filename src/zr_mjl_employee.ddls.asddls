@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee'
define root view entity ZR_MJL_EMPLOYEE
  as select from zmjl_employee
  
  //Foreign keys
  composition [0..*] of ZR_MJL_HCLAIM   as _HCLAIM
  composition [0..*] of ZR_MJL_HREQUEST as _HREQUEST
  
  //Associations for holiday data 
  association [1..1] to ZI_MJL_PLANNED_HOLIDAYS  as _PLANNED on  $projection.EmployeeUuid = _PLANNED.ApplicantUuid
  association [1..1] to ZI_MJL_USED_HOLIDAYS  as _USED on  $projection.EmployeeUuid = _USED.ApplicantUuid
  association [1..1] to ZI_MJL_USABLE_HOLIDAYS as _USABLE on  $projection.EmployeeUuid = _USABLE.EmployeeUuid
    


{
  key employee_uuid      as EmployeeUuid,
      employee_nr        as EmployeeNr,
      employee_firstname as EmployeeFirstname,
      employee_lastname  as EmployeeLastname,
      employee_entrydate as EmployeeEntrydate,
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      
      //Transient data
      _PLANNED.PlanedDays as PlanedDays,
      _USED.UsedDays as UsedDays,
      _USABLE.UsableDays as UsableDays,

      //Associations
     _HCLAIM,
     _HREQUEST
     
}
