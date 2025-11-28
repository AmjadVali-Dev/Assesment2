report 50305 "Purchase SetData Report"
{
    ApplicationArea = All;
    Caption = 'Purchase SetData Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\PurchaseSetDataReport.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(BuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(No; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
        }
    }
}
