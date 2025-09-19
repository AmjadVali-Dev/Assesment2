pageextension 50304 "Purchase Invoice Lines" extends "Posted Purchase Invoice Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Requisition No."; Rec."Requisition No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition No. field.', Comment = '%';
            }
            field("Requisition Line No."; Rec."Requisition Line No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition Line No. field.', Comment = '%';
            }
        }
    }
}
