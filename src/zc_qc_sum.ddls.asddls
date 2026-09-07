@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'QC Document'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_QC_SUM as select from I_InspectionLot
{
  key MaterialDocument,
  key MaterialDocumentYear,

  max(InspectionLot)               as QcDocument,
  max(InspLotCreatedOnLocalDate)   as QcCreationDate,
  max(MatlDocLatestPostgDate)      as QcDate
}
group by MaterialDocument, MaterialDocumentYear
