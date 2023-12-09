@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planned holidays'

define view entity ZI_MJL_PLANNED_HOLIDAYS
  as select from zmjl_hrequest
{
  applicant_uuid     as ApplicantUuid,

  sum(hreqeust_days) as PlanedDays

}
where
  hrequest_status = 'R'
group by
  applicant_uuid;
