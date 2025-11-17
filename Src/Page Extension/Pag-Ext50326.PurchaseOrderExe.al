pageextension 50326 "Purchase Order Exe" extends "Purchase Order"
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
