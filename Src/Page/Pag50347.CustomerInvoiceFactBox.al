page 50347 "Customer Invoice FactBox"
{
    ApplicationArea = All;
    Caption = 'Customer Invoice FactBox';
    PageType = ListPart;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the sales document number.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Specifies the amount that remains to be paid on the sales documents.';
                }
            }
        }
    }
}
