@EndUserText.label: 'Holiday Requests App 2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_MJL_HREQUEST_APP2
  as projection on ZR_MJL_HREQUEST
{
  key HrequestId,
      ApplicantUuid,
      SuperiorUuid,
      HrequestStartdate,
      HrequestEnddate,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      HrequestComment,
      @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_MJL_STATUSVH', element: 'Status'} }]
      HrequestStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      HrequestDays,

      //Transient Data
      StatusCriticality,
      EmployeeName,
      StatusText,
      ApplicantName,

      // Associations
      _APPLICANT : redirected to parent ZC_MJL_EMPLOYEE_APP2,
      _SUPERIOR  : redirected to ZC_MJL_EMPLOYEE
}
