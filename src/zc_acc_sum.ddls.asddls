@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accounting Summary'
@Metadata.allowExtensions: true
define view entity ZC_ACC_SUM
  as select from I_AccountingDocumentJournal( P_Language : 'E')
{
  key ReferenceDocument,
  key FiscalYear,
  key CompanyCode,
      AccountingDocument,
      sum(
              case
                         when TransactionTypeDetermination = 'PRD'
                         then
                             case
                                 when DebitCreditCode = 'S'
                                 then cast( DebitAmountInTransCrcy as abap.dec(23,2) )
                                 else - cast( CreditAmountInTransCrcy as abap.dec(23,2) )
                             end
                         else cast( 0 as abap.dec(23,2) )
                     end ) as PriceDifference
}
where
   Ledger                       = '0L'
group by
  ReferenceDocument,
  FiscalYear,
  CompanyCode,
  AccountingDocument
