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
    actions
    {
        addlast(processing)
        {
            action("Lot No Allocation")
            {
                ApplicationArea = All;
                Caption = 'Lot No Allocation';
                Image = New;
                trigger OnAction()
                var
                    PurchaseLotReservationMgt: Codeunit "Purchase Lot Reservation Mgt";
                begin
                    PurchaseLotReservationMgt.ReservePurchaseLots(Rec);
                end;
            }
        }
    }
}
