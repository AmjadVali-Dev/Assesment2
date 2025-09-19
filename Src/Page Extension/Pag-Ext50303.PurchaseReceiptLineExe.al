pageextension 50303 "PurchaseReceipt Line Exe" extends "Posted Purchase Receipt Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Requisition No."; Rec."Requisition No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies thSSe value of the Requisition No. field.', Comment = '%';
            }
            field("Requisition Line No."; Rec."Requisition Line No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition Line No. field.', Comment = '%';
            }
        }
    }
}
