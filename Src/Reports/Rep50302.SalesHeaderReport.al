report 50302 "Sales Header Report"
{
    ApplicationArea = All;
    Caption = 'Sales Header Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\SalesHeaderReport.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.") { }
            dataitem(SalesHeader; "Sales Header")
            {
                DataItemLink = "Sell-to Customer No." = field("No.");
                column(DocumentType; "Document Type")
                {
                }
                column(SelltoCustomerNo; "Sell-to Customer No.")
                {
                }
                column(No; "No.")
                {
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(OrderDate; "Order Date")
                {
                }
                column(ShipmentMethodCode; "Shipment Method Code")
                {
                }
                column(SelltoCustomerName; "Sell-to Customer Name")
                {
                }
                trigger OnPreDataItem()
                begin
                    Counter := 0;
                end;

                trigger OnAfterGetRecord()

                begin
                    Counter := Counter + 1;
                    if Counter > 10 then begin
                        CurrReport.Break();
                    end;
                end;
            }
        }
    }
    var
        Counter: Integer;

}
