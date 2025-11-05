report 50302 "Sales Header Report"
{
    ApplicationArea = All;
    Caption = 'Sales Header Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\SalesHeaderReport.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(DocumentType; "Document Type") { }
            column(SelltoCustomerNo; "Sell-to Customer No.") { }
            column(No; "No.") { }
            column(PostingDate; Format("Posting Date", 0, '<Day,2> <Month Text,3> <Year4>')) { }
            column(OrderDate; Format("Order Date", 0, '<Day,2> <Month Text,3> <Year4>')) { }
            column(ShipmentMethodCode; "Shipment Method Code") { }
            column(SelltoCustomerName; "Sell-to Customer Name") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(No_; "No.") { }
                column(Quantity; Quantity) { }
                column(Line_Amount; "Line Amount") { }
                column(Description; Description) { }
                trigger OnPreDataItem()
                begin
                    Counter := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    if counter > 10 then
                        CurrReport.Break();
                end;
            }
        }

    }
    var
        Counter: Integer;
}
