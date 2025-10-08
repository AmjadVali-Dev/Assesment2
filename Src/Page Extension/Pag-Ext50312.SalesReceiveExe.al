pageextension 50312 "Sales & Receive Exe" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(content)
        {
            field("No.Gen"; Rec."No.Gen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No.Gen field.', Comment = '%';
            }
        }
    }
}
