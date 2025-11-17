pageextension 50328 "Dtld Vendor Ledger Entry exe" extends "Detailed Vendor Ledg. Entries"
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
