@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Usable Holidays'

define view entity ZI_MJL_USABLE_HOLIDAYS
  as select from zmjl_hclaim

  //Associations for holiday data
  association [1..1] to ZI_MJL_PLANNED_HOLIDAYS as _PLANNED on $projection.EmployeeUuid = _PLANNED.ApplicantUuid
  association [1..1] to ZI_MJL_USED_HOLIDAYS    as _USED    on $projection.EmployeeUuid = _USED.ApplicantUuid

{
  employee_uuid                                                                  as EmployeeUuid,


  sum(hlcaim_days)- coalesce(_PLANNED.PlanedDays,0) - coalesce(_USED.UsedDays,0) as UsableDays,

  _PLANNED,
  _USED

}
group by
  employee_uuid,
  _PLANNED.PlanedDays,
  _USED.UsedDays
