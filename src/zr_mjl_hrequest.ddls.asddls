@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Requests'
define view entity ZR_MJL_HREQUEST
  as select from zmjl_hrequest
  association        to parent ZR_MJL_EMPLOYEE as _APPLICANT     on  $projection.ApplicantUuid = _APPLICANT.EmployeeUuid
  association [1..1] to ZR_MJL_EMPLOYEE        as _SUPERIOR      on  $projection.SuperiorUuid = _SUPERIOR.EmployeeUuid


  //Associations for text elements
  association [1..1] to ZI_MJL_EMPLOYEE_Text   as _EMPLOYEETEXT  on  $projection.SuperiorUuid = _EMPLOYEETEXT.EmployeeUuid
  association [1..1] to ZI_MJL_EMPLOYEE_Text   as _APPLICANTTEXT on  $projection.ApplicantUuid = _APPLICANTTEXT.EmployeeUuid

  //Association for validation
  association [1..1] to ZI_MJL_USABLE_HOLIDAYS as _USABLE        on  $projection.ApplicantUuid = _USABLE.EmployeeUuid


  //Association for status value help
  association [1..1] to ZI_MJL_StatusVH        as _STATUSTEXT    on  $projection.HrequestStatus = _STATUSTEXT.Status
                                                                 and _STATUSTEXT.language       = $session.system_language


{
  key hrequest_id            as HrequestId,
      @ObjectModel.text.element: [ 'ApplicantName' ]
      applicant_uuid         as ApplicantUuid,
      @ObjectModel.text.element: [ 'EmployeeName' ]
      superior_uuid          as SuperiorUuid,
      hrequest_startdate     as HrequestStartdate,
      hrequest_enddate       as HrequestEnddate,
      hrequest_comment       as HrequestComment,
      @ObjectModel.text.element: [ 'StatusText' ]
      hrequest_status        as HrequestStatus,
      @Semantics.user.createdBy: true
      created_by             as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at             as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by        as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at        as LastChangedAt,
      hreqeust_days          as HrequestDays,


      //Transient data
      case hrequest_status
                when 'R' then 2
                when 'A' then 3
                when 'D' then 1
                else 0
      end                    as StatusCriticality,
      _EMPLOYEETEXT.Name     as EmployeeName,
      _STATUSTEXT.StatusDone as StatusText,
      _APPLICANTTEXT.Name    as ApplicantName,
      _USABLE.UsableDays     as UsableDays,

      //Associations
      _APPLICANT, 
      _SUPERIOR


}
