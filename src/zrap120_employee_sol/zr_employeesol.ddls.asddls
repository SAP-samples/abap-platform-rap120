@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_EMPLOYEESOL
  as select from zemployeesol as Employee

  association of many to one ZR_EMPLOYEESOL as _Manager on $projection.ManagerUuid = _Manager.Uuid
{
  key uuid         as Uuid,
      employee_id  as EmployeeId,
      first_name   as FirstName,
      last_name    as LastName,
      salary_curr  as SalaryCurr,
      @Semantics.amount.currencyCode: 'SalaryCurr'
      salary       as Salary,
      manager_id   as ManagerId,
      manager_uuid as ManagerUuid,

      /* Public Associations */
      _Manager

}
