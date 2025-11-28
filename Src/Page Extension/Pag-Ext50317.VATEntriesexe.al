pageextension 50317 "VAT Entries exe" extends "VAT Entries"
{
    layout
    {
        addlast(content)
        {
            field("Field Test"; Rec."Field Test")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Field Test field.', Comment = '%';
            }
            field("Field Testing"; Rec."Field Testing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Field Testing field.', Comment = '%';
            }
        }
    }
}
