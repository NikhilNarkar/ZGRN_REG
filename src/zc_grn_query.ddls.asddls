@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GRN Register Query'
@Metadata.allowExtensions: true
@ObjectModel.modelingPattern: #ANALYTICAL_QUERY
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_QUERY ]
@Analytics.query: true
define view entity ZC_GRN_QUERY
  as select from ZI_GRN_CUBE
{
  key matdocyear,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_MaterialDocumentHeader_2', element: 'MaterialDocument' } }]
  key matdoc,
  key matdocitem,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_PurchaseOrderType', element: 'PurchaseOrderType' } }]
      PurchaseOrderType,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      FiscalYear,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductDescription', element: 'Product' } }]
      matnr,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      SupplierInvoice,
      ProductDescription,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Plant', element: 'Plant' } }]
      Plant,
      storageloc,
      Batch,
      shelfdt,
      mdate,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Supplier', element: 'Supplier' } }]
      Supplier,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_GoodsMovementTypeT', element: 'GoodsMovementType' } }]
      mvttype,
      matunit,
      qty,
      @Consumption.filter: {
      selectionType: #INTERVAL,
      multipleSelections: false,
      mandatory: false
      }
      postdate,
      docdate,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_PurchaseOrderAPI01', element: 'PurchaseOrder' } }]
      po,
      poitem,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      compcode,
      doccurr,
      CompanyCodeCurrency,
      totamt,
      stocktyp,
      refdocyear,
      refdocument,
      refdocitem,
      netamt,
      NetAmount,
      matgrp,
      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true, mandatory: false }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductTypeText_2', element: 'ProductType' } }]
      mattype,
      MaterialTypeName,
      potext,
      gst,
      hsn,
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
      InvoiceAmount,
      DocumentCurrency,
      QcDoc,
      QcCreationdate,
      QcDate,
      AdditionalDuty,
      BasicCustoms,
      CHACharges,
      FreightCharges,
      LandCharges,
      OtherCharges,
      OverheadFreight,
      PackingCharges,
      PnFCharges,
      TotalTaxes,
      CVDAmt,
      PriceDifference,
      AccountingDocument,
      YY1_GateIn_MMI,
      BillOfLading,
      TotalAmount
}
