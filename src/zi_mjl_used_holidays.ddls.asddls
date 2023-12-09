@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Used Holidays'


define view entity ZI_MJL_USED_HOLIDAYS
  as select from zmjl_hrequest
{
  applicant_uuid     as ApplicantUuid,
  sum(hreqeust_days) as UsedDays
}

where
  hrequest_status = 'A'
group by
  applicant_uuid
