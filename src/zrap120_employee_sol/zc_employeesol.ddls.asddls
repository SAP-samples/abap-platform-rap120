@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true

@OData.hierarchy.recursiveHierarchy:[{ entity.name: 'ZI_EmployeeHN_SOL' }]

define root view entity ZC_EMPLOYEESOL
  //  provider contract transactional_query
  as projection on ZR_EMPLOYEESOL

  association of many to one ZC_EMPLOYEESOL as _Manager on $projection.ManagerUuid = _Manager.Uuid
{
  key Uuid,
      EmployeeId,
      @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold:  0.8
      }
      FirstName,
      @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold:  0.8
      }
      LastName,
      @Semantics.currencyCode: true
      SalaryCurr,
      Salary,
      @ObjectModel.text.element: ['_Manager.LastName']
      ManagerId,
      ManagerUuid,

      /* Public Associations */
      _Manager
}
