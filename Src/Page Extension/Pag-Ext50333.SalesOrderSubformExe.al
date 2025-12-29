pageextension 50333 "Sales Order Subform Exe" extends "Sales Order Subform"
{
    actions
    {
        addlast(processing)
        {
            action(ReserveLots)
            {
                Caption = 'Reserve Lots';
                ApplicationArea = All;
                Image = Reserve;

                trigger OnAction()
                var
                    LotResMgt: Codeunit "Lot Reservation Mgt";
                begin
                    LotResMgt.ReserveByLot(Rec);
                    Message('Reservation Completed!');
                end;
            }
        }
    }
}
