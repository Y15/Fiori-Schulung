@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Kundenauftrag mit Position'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZA1_C_SALES_ORDER
  as select from vbak
  association [1..*] to vbap as _positionen on _positionen.vbeln = vbak.vbeln

{
  key vbak.vbeln,
      
  ernam
}
