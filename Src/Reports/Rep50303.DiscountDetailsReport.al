report 50303 "Discount Details Report"
{
    Caption = 'Discount Details Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Reports\DiscountDetailsReport.rdl';
    dataset
    {
        dataitem("Discount Details"; "Discount Details")
        {
            column(Entry_No_; "Entry No.") { }
            column(Discount_Code; "Discount Code") { }
            column(Description; Description) { }
            column(Discount_Percent; "Discount Percent") { }
            column(Valid_From; "Valid From") { }
            column(Valid_To; "Valid To") { }
            column(AppliesTo; AppliesTo) { }
            column(Is_Active; "Is Active") { }

            trigger OnPreDataItem()
            begin
                if EntryNo <> 0 then
                    "Discount Details".SetRange("Entry No.", EntryNo);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field(EntryNo; EntryNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Entry No.';
                        ToolTip = 'Filter by Entry No.';
                    }
                }
            }
        }
    }
    var
        EntryNo: Integer;


}
