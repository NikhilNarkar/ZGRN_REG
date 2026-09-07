@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GRN Register Cube'
@Metadata.allowExtensions: true
@Analytics.dataCategory: #CUBE
define view entity ZI_GRN_CUBE
  as select from ZCE_GRN
{
  key matdocyear,
  key matdoc,
  key matdocitem,
      PurchaseOrderType,
      FiscalYear,
      matnr,
      SupplierInvoice,
      ProductDescription,
      Plant,
      storageloc,
      Batch,
      shelfdt,
      mdate,
      Supplier,
      mvttype,
      matunit,
      @Semantics.quantity.unitOfMeasure : 'matunit'
      @Aggregation.default: #SUM
      qty,
      postdate,
      docdate,
      po,
      poitem,
      compcode,
      doccurr,
      CompanyCodeCurrency,
      @Semantics.amount.currencyCode : 'CompanyCodeCurrency'
      @Aggregation.default: #SUM
      totamt,
      stocktyp,
      refdocyear,
      refdocument,
      refdocitem,
      @Semantics.amount.currencyCode : 'doccurr'
      @Aggregation.default: #SUM
      netamt,
      @Semantics.amount.currencyCode : 'doccurr'
      @Aggregation.default: #SUM
      NetAmount,
      matgrp,
      mattype,
      MaterialTypeName,
      potext,
      gst,
      hsn,
      @Semantics.quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit'
      @Aggregation.default: #SUM
      OrderQuantity,
      PurchaseOrderQuantityUnit,
      PurchaseRequisition,
      PurchaseReqnCreationDate,
      RequisitionerName,
      podate,
      erate,
      IncotermsLocation1,
      matgrpname,
      suppname,
      storgloc,
      ExternalProductGroup,
      ExternalProductGroupName,
      ReferenceDocument,
      MaterialDocumentHeaderText,
      MaterialDocumentItemText,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @Aggregation.default: #SUM
      InvoiceAmount,
      DocumentCurrency,
      QcDoc,
      QcCreationdate,
      QcDate,
      @Aggregation.default: #SUM
      AdditionalDuty,
      @Aggregation.default: #SUM
      BasicCustoms,
      @Aggregation.default: #SUM
      CHACharges,
      @Aggregation.default: #SUM
      FreightCharges,
      @Aggregation.default: #SUM
      LandCharges,
      @Aggregation.default: #SUM
      OtherCharges,
      @Aggregation.default: #SUM
      OverheadFreight,
      @Aggregation.default: #SUM
      PackingCharges,
      @Aggregation.default: #SUM
      PnFCharges,
      @Aggregation.default: #SUM
      TotalTaxes,
      @Aggregation.default: #SUM
      CVDAmt,
      @Aggregation.default: #SUM
      PriceDifference,
      AccountingDocument,
      YY1_GateIn_MMI,
      BillOfLading,
      @Aggregation.default: #SUM
      TotalAmount
}
