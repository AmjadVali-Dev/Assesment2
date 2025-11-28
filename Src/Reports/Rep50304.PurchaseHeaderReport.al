report 50304 "Purchase Header Report"
{
    ApplicationArea = All;
    Caption = 'Purchase Header Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\PurchaseHeader.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(No; "No.") { }
            column(Picture; CompanyInfo.Picture) { }
            column(BuyfromVendorNo; "Buy-from Vendor No.") { }
            column(BuyfromVendorName; "Buy-from Vendor Name") { }
            column(DocumentDate; Format("Document Date", 0, '<Day,2> <Month Text,3> <Year4>')) { }
            column(OrderDate; Format("Order Date", 0, '<Day,2> <Month Text,3> <Year4>')) { }
            column(BuyfromCountryRegionCode; CountryRegionName) { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(Type; Type) { }
                column(No_; "No.") { }
                column(Description; Description) { }
                column(Amount; Amount) { }
                column(Quantity; Quantity) { }

            }
            trigger OnAfterGetRecord()
            var
                CountryRegionL: Record "Country/Region";
            begin
                if CountryRegionL.Get("Buy-from Country/Region Code") then
                    CountryRegionName := CountryRegionL.Name;
            end;
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CountryRegionName: Text[50];


}
