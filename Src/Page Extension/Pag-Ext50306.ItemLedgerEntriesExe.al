pageextension 50306 "Item Ledger Entries Exe" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Requisition No."; Rec."Requisition No.S")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition No. field.', Comment = '%';
            }
            field("Requisition Line No."; Rec."Requisition Line No.S")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition Line No. field.', Comment = '%';
            }
        }
    }
}

