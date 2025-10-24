report 50301 "Pending Purchase RequisationA"
{
    ApplicationArea = All;
    Caption = 'Pending Purchase RequisationA';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\PendingPurchaseRequisation.rdl';

    dataset
    {
        dataitem(PurchaseRequisitionLine; "Purchase Requisition Line")
        {
            DataItemTableView = where("Purchase Order No." = const(''), "Purchase Order Line No." = const(0));
            column(No; "No.") { }
            column(LineNo; "Line No.") { }
            column(ItemNo; "Item No.") { }
            column(Description; Description) { }
            column(UnitOfMeasureCode; "Unit Of Measure Code") { }
            column(Quantity; Quantity) { }
            column(RequisitionDate; "Requisition Date") { }
            column(Department; Department) { }
            column(Line_No_; "Line No.") { }
            column(CreatedByG; CreatedByG) { }
            column(CreatedDateG; CreatedDateG) { }
            column(ReleasedByG; ReleasedByG) { }
            column(ReleasedDateG; ReleasedDateG) { }
            trigger OnAfterGetRecord()
            var
                PurchHeaderRec: Record "Purchase Requisition Header";
            begin
                if PurchHeaderRec.Get("No.") then begin
                    CreatedByG := PurchHeaderRec."Created By";
                    CreatedDateG := PurchHeaderRec."Created Date";
                    ReleasedByG := PurchHeaderRec."Released By";
                    ReleasedDateG := PurchHeaderRec."Released Date";
                end;
            end;
        }
    }
    var
        CreatedByG: Code[20];
        CreatedDateG: Date;
        ReleasedByG: Code[20];
        ReleasedDateG: Date;
}