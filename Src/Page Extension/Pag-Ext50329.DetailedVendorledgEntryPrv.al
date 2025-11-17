pageextension 50329 "Detailed Vendor ledg Entry Prv" extends "Detailed Vend. Entries Preview"
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
