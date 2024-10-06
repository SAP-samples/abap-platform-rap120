@EndUserText.label: 'Agency abtract entity'
define abstract entity ZA_AGENCY_SOL
{
  agency_id   : abap.numc(6);
  agency_name : abap.char(80);
  created_by  : abp_creation_user;
  created_at  : abp_creation_tstmpl;
}
