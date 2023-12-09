@EndUserText.label: 'Holiday claim'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity ZC_MJL_HCLAIM

  as projection on ZR_MJL_HCLAIM
{
  key HclaimId,
      EmployeeUuid,
      HlcaimYear,
      HlcaimDays,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      /* Associations */
      _EMPLOYEE : redirected to parent ZC_MJL_EMPLOYEE,

      //Transient Data
      EmployeeName
}
