codeunit 50324 "Lot Reservation Mgt"
{
    procedure ReserveByLot(SalesLine: Record "Sales Line")
    var
        ILE: Record "Item Ledger Entry";

    begin
        if SalesLine."Quantity (Base)" <= 0 then
            Error('Quantity must be greater than 0');

        RemainingQty := SalesLine."Quantity (Base)";

        ILE.Reset();
        ILE.SetRange("Item No.", SalesLine."No.");
        ILE.SetRange("Location Code", SalesLine."Location Code");
        ILE.SetFilter("Expiration Date", '<>%1', 0D);
        ILE.SetFilter("Lot No.", '<>%1', '');
        ILE.SetFilter("Remaining Quantity", '>0');
        ILE.SetCurrentKey("Expiration Date");   // FEFO
        ILE.Ascending(true);

        if not ILE.FindSet() then
            Error('No available lots for this Item.');

        repeat
            if RemainingQty <= 0 then
                exit;
            LotQty := ILE."Remaining Quantity";
            if LotQty >= RemainingQty then begin//  if here The Remaining Qty is Low We will Insert The remaining Qty and exit
                                                //Lot Qty=150 >= Remaining Qty=200 false  Soo we go to else 
                InsertReservationEntry(SalesLine, ILE, RemainingQty);
                RemainingQty := 0;
            end else begin  // if here The Lot Qty is Low We will Insert The Lot Qty and continue to next lot
                InsertReservationEntry(SalesLine, ILE, LotQty);
                RemainingQty -= LotQty;
            end;
        until ILE.Next() = 0;
    end;

    procedure InsertReservationEntry(SalesLine: Record "Sales Line"; ILE: Record "Item Ledger Entry"; QtyBase: Decimal)
    var
    begin
        ReservationEntry.Init();
        ReservationEntry."Entry No." := GetNextEntryNo();
        ReservationEntry."Item No." := SalesLine."No.";
        ReservationEntry."Location Code" := SalesLine."Location Code";
        ReservationEntry."Variant Code" := SalesLine."Variant Code";
        ReservationEntry."Source Type" := DATABASE::"Sales Line";
        ReservationEntry."Source ID" := SalesLine."Document No.";
        ReservationEntry."Source Ref. No." := SalesLine."Line No.";
        ReservationEntry.Description := SalesLine.Description;
        ReservationEntry."Lot No." := ILE."Lot No.";
        ReservationEntry.Positive := false;
        ReservationEntry."Expiration Date" := ILE."Expiration Date";
        ReservationEntry."Item Ledger Entry No." := ILE."Entry No.";
        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Reservation;
        ReservationEntry."Creation Date" := WorkDate();
        ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"1";
        ReservationEntry.Validate("Quantity (Base)", -QtyBase);
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry.Insert();
    end;



    procedure GetNextEntryNo(): Integer
    var
        Res: Record "Reservation Entry";
    begin
        if Res.FindLast() then
            exit(Res."Entry No." + 1)
        else
            exit(1);
    end;

    var
        ReservationEntry: Record "Reservation Entry";
        RemainingQty: Decimal;
        LotQty: Decimal;

}
