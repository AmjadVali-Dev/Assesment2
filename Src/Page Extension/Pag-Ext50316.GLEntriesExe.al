pageextension 50316 "G/L Entries Exe" extends "G/L Entries Preview"
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
