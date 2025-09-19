pageextension 50300 "Purchase & Payble SetUp Exe" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Invoice Nos.")
        {
            field("Requisition Nos."; Rec."Requisition Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition Nos. field.', Comment = '%';
            }
        }

    }
}
