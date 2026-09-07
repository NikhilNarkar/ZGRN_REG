@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GRN Register'
@Metadata.allowExtensions: true
define root view entity ZCE_GRN
  as select distinct from I_MaterialDocumentItem_2       as a
    left outer join       I_PurchaseOrderItemAPI01       as b on  b.PurchaseOrder     = a.PurchaseOrder
                                                              and b.PurchaseOrderItem = a.PurchaseOrderItem
    left outer join       I_PurchaseOrderAPI01           as c on c.PurchaseOrder = a.PurchaseOrder
    left outer join       I_ProductGroupText_2           as d on  d.ProductGroup = b.MaterialGroup
                                                              and d.Language     = 'E'
    left outer join       I_Supplier                     as E on E.Supplier = a.Supplier
    left outer join       I_MaterialDocumentHeader_2     as F on  F.MaterialDocument     = a.MaterialDocument
                                                              and F.MaterialDocumentYear = a.MaterialDocumentYear
    left outer join       I_StorageLocation              as g on  g.Plant           = a.Plant
                                                              and g.StorageLocation = a.StorageLocation
    left outer join       I_ProductPlantBasic            as h on  b.Material = h.Product
                                                              and b.Plant    = h.Plant
    left outer join       I_PurchaseRequisitionItemAPI01 as i on  b.PurchaseRequisition     = i.PurchaseRequisition
                                                              and b.PurchaseRequisitionItem = i.PurchaseRequisitionItem
    left outer join       I_Product                      as j on b.Material = j.Product
    left outer join       I_ExtProdGrpText               as k on j.ExternalProductGroup = k.ExternalProductGroup
    left outer join       ZC_PO_PRICING_SUM              as m on  b.PurchaseOrder     = m.PurchaseOrder
                                                              and b.PurchaseOrderItem = m.PurchaseOrderItem
    left outer join       I_ProductDescription           as n on a.Material = n.Product
    left outer join       I_ProductTypeText              as o on b.MaterialType = o.ProductType
    left outer join       ZC_INV_SUM                     as p on  b.PurchaseOrder     = p.PurchaseOrder
                                                              and b.PurchaseOrderItem = p.PurchaseOrderItem
                                                              and a.MaterialDocument  = p.ReferenceDocument
    left outer join       I_InspectionLot                as q on  a.Batch    = q.Batch
                                                              and a.Plant    = q.Plant
                                                              and a.Material = q.Material
    left outer join       ZC_ACC_SUM                     as r on  p.SupplierInvoice = r.ReferenceDocument
                                                              and p.FiscalYear      = r.FiscalYear
                                                              and a.CompanyCode     = r.CompanyCode
    left outer join       I_Plant                        as s on s.Plant = c.SupplyingPlant
    left outer join       I_JournalEntry                 as FI on  FI.CompanyCode               = a.CompanyCode
                                                              and FI.OriginalReferenceDocument = concat( a.MaterialDocument, a.MaterialDocumentYear )
                                                              and FI.ReferenceDocumentType     = 'MKPF'
{
  key a.MaterialDocumentYear              as matdocyear,
  key a.MaterialDocument                  as matdoc,
  key a.MaterialDocumentItem              as matdocitem,
      c.PurchaseOrderType,
      p.FiscalYear,
      a.Material                          as matnr,
      p.SupplierInvoice,
      n.ProductDescription,
      a.Plant,
      a.StorageLocation                   as storageloc,
      a.Batch,
      a.ShelfLifeExpirationDate           as shelfdt,
      a.ManufactureDate                   as mdate,
      case
      when c.PurchaseOrderType = 'ZFUB'
      or c.PurchaseOrderType = 'ZFDN'
      then c.SupplyingPlant
      else a.Supplier
      end                                 as Supplier,
      a.GoodsMovementType                 as mvttype,
      a.EntryUnit                         as matunit,
      @Semantics.quantity.unitOfMeasure : 'matunit'
      case a.GoodsMovementType
        when '102' then a.QuantityInEntryUnit * -1
        else a.QuantityInEntryUnit
      end                                 as qty,
      cast( a.PostingDate as abap.dats )  as postdate,
      cast( a.DocumentDate as abap.dats ) as docdate,
      a.PurchaseOrder                     as po,
      a.PurchaseOrderItem                 as poitem,
      a.CompanyCode                       as compcode,
      b.DocumentCurrency                  as doccurr,
      a.CompanyCodeCurrency,
      @Semantics.amount.currencyCode : 'CompanyCodeCurrency'
      a.TotalGoodsMvtAmtInCCCrcy          as totamt,
      a.InventoryStockType                as stocktyp,
      a.ReferenceDocumentFiscalYear       as refdocyear,
      a.InvtryMgmtReferenceDocument       as refdocument,
      a.InvtryMgmtRefDocumentItem         as refdocitem,
      @Semantics.amount.currencyCode : 'doccurr'
      b.NetPriceAmount                    as netamt,
      @Semantics.amount.currencyCode : 'doccurr'
      b.NetAmount,
      b.MaterialGroup                     as matgrp,
      b.MaterialType                      as mattype,
      o.MaterialTypeName,
      b.PurchaseOrderItemText             as potext,
      b.TaxCode                           as gst,
      h.ConsumptionTaxCtrlCode            as hsn,
      @Semantics.quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit'
      b.OrderQuantity,
      b.PurchaseOrderQuantityUnit,
      b.PurchaseRequisition,
      i.PurchaseReqnCreationDate,
      b.RequisitionerName,
      c.PurchaseOrderDate                 as podate,
      c.ExchangeRate                      as erate,
      FI.AbsoluteExchangeRate             as FIExchangeRate,
      c.IncotermsLocation1,
      d.ProductGroupName                  as matgrpname,
      case
      when c.PurchaseOrderType = 'ZFUB'
      or c.PurchaseOrderType = 'ZFDN'
       then s.PlantName
      else E.SupplierName
      end                                 as suppname,
      g.StorageLocationName               as storgloc,
      j.ExternalProductGroup,
      k.ExternalProductGroupName,
      F.ReferenceDocument,
      F.MaterialDocumentHeaderText,
      a.MaterialDocumentItemText,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      p.InvoiceAmount,
      p.DocumentCurrency,
      max(q.MaterialDocument)             as QcDoc,
      max(q.InspLotCreatedOnLocalDate)    as QcCreationdate,
      max(q.MatlDocLatestPostgDate)       as QcDate,

      max(m.AdditionalDuty)               as AdditionalDuty,
      max(m.BasicCustoms)                 as BasicCustoms,
      max(m.CHACharges)                   as CHACharges,
      max(m.FreightCharges)               as FreightCharges,
      max(m.LandCharges)                  as LandCharges,
      max(m.OtherCharges)                 as OtherCharges,
      max(m.OverheadFreight)              as OverheadFreight,
      max(m.PackingCharges)               as PackingCharges,
      max(m.PnFCharges)                   as PnFCharges,
      max(m.TotalTaxes)                   as TotalTaxes,
      max(m.CVDAmt)                       as CVDAmt,
      max( r.PriceDifference )            as PriceDifference,
      r.AccountingDocument,
      a.YY1_GateIn_MMI,
      F.BillOfLading,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @Aggregation.default: #SUM
      max(
      /* Base and Taxes */
      //        coalesce(cast( f.InvoiceAmount as abap.dec(23,2) ), 0) +

      /* Adjustments */
        coalesce(cast( r.PriceDifference as abap.dec(23,2) ), 0) +

      //        coalesce(cast( i.TCS as abap.dec(23,2) ), 0)  +

      /* Pricing Charges from q */
      coalesce(cast(m.TotalTaxes  as abap.dec(23,2) ), 0)  +
      coalesce(cast(m.AdditionalDuty as abap.dec(23,2) ), 0)  +
        coalesce(cast(m.OtherCharges as abap.dec(23,2) ), 0)  +
        coalesce(cast(m.CHACharges as abap.dec(23,2) ), 0)  +
        coalesce(cast( m.LandCharges as abap.dec(23,2) ), 0)   +
        coalesce(cast( m.FreightCharges as abap.dec(23,2) ), 0) +
        coalesce(cast(m.PackingCharges as abap.dec(23,2) ), 0)  +
        coalesce(cast(m.PnFCharges as abap.dec(23,2) ), 0)  +
        coalesce(cast( m.CVDAmt as abap.dec(23,2) ), 0)        +
        coalesce(cast( m.BasicCustoms as abap.dec(23,2) ), 0)  +
        coalesce(cast( m.OverheadFreight as abap.dec(23,2) ), 0)

      )                                   as TotalAmount
}
where
        a.PurchaseOrder     <> ''
  and(
        a.GoodsMovementType <> '321'
    and a.GoodsMovementType <> '322'
    and a.GoodsMovementType <> '350'
  )
group by
  a.MaterialDocumentYear,
  a.MaterialDocument,
  a.MaterialDocumentItem,
  a.Material,
  n.ProductDescription,
  a.Plant,
  a.StorageLocation,
  a.Batch,
  a.ShelfLifeExpirationDate,
  a.ManufactureDate,
  a.Supplier,
  a.GoodsMovementType,
  a.EntryUnit,
  a.QuantityInEntryUnit,
  a.PostingDate,
  a.DocumentDate,
  a.PurchaseOrder,
  a.PurchaseOrderItem,
  c.PurchaseOrderType,
  c.SupplyingPlant,
  s.PlantName,
  a.CompanyCode,
  b.DocumentCurrency,
  a.CompanyCodeCurrency,
  a.TotalGoodsMvtAmtInCCCrcy,
  a.InventoryStockType,
  a.ReferenceDocumentFiscalYear,
  a.InvtryMgmtReferenceDocument,
  a.InvtryMgmtRefDocumentItem,
  b.NetPriceAmount,
  b.NetAmount,
  b.MaterialGroup,
  b.MaterialType,
  o.MaterialTypeName,
  b.PurchaseOrderItemText,
  b.TaxCode,
  h.ConsumptionTaxCtrlCode,
  b.PurchaseRequisition,
  i.PurchaseReqnCreationDate,
  b.RequisitionerName,
  b.OrderQuantity,
  b.PurchaseOrderQuantityUnit,
  c.PurchaseOrderDate,
  c.ExchangeRate,
  FI.AbsoluteExchangeRate,
  c.IncotermsLocation1,
  d.ProductGroupName,
  E.SupplierName,
  g.StorageLocationName,
  j.ExternalProductGroup,
  k.ExternalProductGroupName,
  F.ReferenceDocument,
  F.MaterialDocumentHeaderText,
  a.MaterialDocumentItemText,
  p.SupplierInvoice,
  p.FiscalYear,
  p.InvoiceAmount,
  p.DocumentCurrency,
  r.PriceDifference,
  r.AccountingDocument,
  a.YY1_GateIn_MMI,
  F.BillOfLading
