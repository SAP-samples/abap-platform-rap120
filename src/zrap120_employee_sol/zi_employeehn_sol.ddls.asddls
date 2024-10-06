@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Hierarchy: Read Only: Employee Hierarchy'

define hierarchy ZI_EMPLOYEEHN_SOL
  as parent child hierarchy(

    source ZR_EMPLOYEESOL

    child to parent association _Manager

    start where
      ManagerUuid is initial

    siblings order by
      LastName ascending
  )
{
  key Uuid,
      ManagerUuid
}
