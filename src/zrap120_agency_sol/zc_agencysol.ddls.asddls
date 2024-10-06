@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true

@ObjectModel.semanticKey: ['AgencyId']

define root view entity ZC_AGENCYSOL
  provider contract transactional_query
  as projection on ZR_AGENCYSOL
{
  key Uuid,
      @Consumption.valueHelpDefinition: [{
            entity : {name: '/DMO/I_Agency_StdVH', element: 'AgencyID'  },
            additionalBinding: [
                                 { localElement: 'AgencyName',  element: 'Name',        usage: #RESULT },
                                 { localElement: 'Street',      element: 'Street',      usage: #RESULT },
                                 { localElement: 'PostalCode',  element: 'PostalCode',  usage: #RESULT },
                                 { localElement: 'City',        element: 'City',        usage: #RESULT } ],
            useForValidation: true }]
      AgencyId,

      @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold:  0.8
      }
      AgencyName,
      Street,
      PostalCode,
      City,
      CountryCode,
      PhoneNumber,
      EmailAddress,
      WebAddress,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt

}
