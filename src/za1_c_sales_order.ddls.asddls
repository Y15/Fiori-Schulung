@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Kundenauftrag mit Position'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI.headerInfo: {
    typeName: 'Kundenauftrag',
    typeNamePlural: 'Kundenaufträge',
    title: {
        value: 'vbeln'
    }
}

@Search.searchable: true

define view entity ZA1_C_SALES_ORDER
  as select from vbak
  association [1..*] to vbap as _positionen on _positionen.vbeln = vbak.vbeln

{
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @UI.lineItem: [{position: 10, importance: #HIGH}]
      @UI.selectionField: [{position: 10}]
  key vbak.vbeln,
      
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 1 }
      @UI.lineItem: [{position: 20, importance: #HIGH}]
      ernam
}
