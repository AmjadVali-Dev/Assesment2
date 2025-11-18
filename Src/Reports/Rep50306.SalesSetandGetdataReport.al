report 50306 "Sales Set and Get data Report"
{
    ApplicationArea = All;
    Caption = 'Sales Set and Get data Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\SalesSetandGetdataReport.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(SelltoCustomerNo; "Sell-to Customer No.") { }
            column(No; "No.") { }
            column(PostingDate; "Posting Date") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(No_; "No.") { }
                column(Quantity; Quantity) { }
                column(Description; Description) { }

            }
        }
    }
}
