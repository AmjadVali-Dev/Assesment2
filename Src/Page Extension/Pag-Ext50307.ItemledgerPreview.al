pageextension 50307 "Item ledger Preview" extends "Item Ledger Entries Preview"
{
    layout
    {
        addafter("Document No.")
        {
            field("Requisition No.S"; Rec."Requisition No.S")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition No. field.', Comment = '%';
            }
            field("Requisition Line No.S"; Rec."Requisition Line No.S")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition Line No. field.', Comment = '%';
            }
        }
    }
}
