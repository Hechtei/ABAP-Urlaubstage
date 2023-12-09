@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help Status'

define view entity ZI_MJL_StatusVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZMJL_HREQUEST_STATUS' )
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @UI.hidden: true
  key language,

      @EndUserText: {label: 'Status', quickInfo: 'Status'}
      value_low                    as Status,
      @EndUserText: {label: 'Status Text', quickInfo: 'Status Text'}
      text                         as StatustText,

      concat_with_space(text,'',1) as StatusDone
}
where
  language = $session.system_language
