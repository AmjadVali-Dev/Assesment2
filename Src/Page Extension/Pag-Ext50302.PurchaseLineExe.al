pageextension 50302 "Purchase Line Exe" extends "Purchase Order Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Requisition No.A"; Rec."Requisition No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition No. field.', Comment = '%';
            }
            field("Requisition Line No.A"; Rec."Requisition Line No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition Line No. field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Get Pending Purchase Lines")
            {
                ApplicationArea = All;
                Image = New;
                Caption = 'Get Pending Purchase Lines';
                trigger OnAction()
                var
                    PurchaseHea: Record "Purchase Header";
                    pendingReq: Page "Pending Release Purchase Req";
                begin
                    pendingReq.SetPurchaseHeader(Rec);
                    pendingReq.Run();
                end;
            }
        }
    }
}
