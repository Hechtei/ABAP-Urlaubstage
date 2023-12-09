@EndUserText.label: 'Holiday Request'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity ZC_MJL_HREQUEST
  as projection on ZR_MJL_HREQUEST
{
  key HrequestId,
      ApplicantUuid,
      @Consumption.valueHelpDefinition: [{ entity: {name:'ZI_MJL_SUPERIORVH',element:'EmployeeId'} }]
      SuperiorUuid,
      HrequestStartdate,
      HrequestEnddate,
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
      _APPLICANT : redirected to parent ZC_MJL_EMPLOYEE,
      _SUPERIOR  : redirected to ZC_MJL_EMPLOYEE


}
