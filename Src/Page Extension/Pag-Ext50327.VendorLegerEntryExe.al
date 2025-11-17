pageextension 50327 "Vendor Leger Entry Exe" extends "Vendor Ledger Entries"
{
    layout
    {
        addlast(content)
        {
            field("Field Testing"; Rec."Field Testing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Field Testing field.', Comment = '%';
            }
        }
    }
}
