codeunit 50325 "Purchase Lot Reservation Mgt"
{
    procedure ReservePurchaseLots(PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        RemainingQty: Decimal;
        LotQty: Decimal;
    begin
        LastEntryNo := 0;

        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetFilter(Quantity, '>0');
        if PurchLine.FindSet() then begin
            repeat
                if not ReservationExists(PurchLine) then begin
                    RemainingQty := PurchLine.Quantity;

                    while RemainingQty > 0 do begin
                        if RemainingQty >= 150 then
                            LotQty := 150
                        else
                            LotQty := RemainingQty;
                        CreateReservationWithLot(PurchLine, LotQty);
                        RemainingQty -= LotQty;
                    end;
                end;
            until PurchLine.Next() = 0;
            Message('Lot No Reservations have been created for Purchase Order %1', PurchHeader."No.");
        end;
    end;


    procedure CreateReservationWithLot(PurchLine: Record "Purchase Line"; QtyBase: Decimal)
    var
        LotNo: Code[20];
    begin
        if not Item.Get(PurchLine."No.") then
            exit;
        Item.TestField("Item Tracking Code");
        Item.TestField("Lot Nos.");
        LotNo := NoSeriesMgt.GetNextNo(Item."Lot Nos.", Today, true);

        ReservationEntry.Init();
        ReservationEntry."Entry No." := GetNextEntryNo();
        ReservationEntry."Item No." := PurchLine."No.";
        ReservationEntry.Description := PurchLine.Description;
        ReservationEntry."Location Code" := PurchLine."Location Code";
        ReservationEntry.Validate("Quantity (Base)", QtyBase);
        ReservationEntry.Positive := true;
        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Reservation;
        ReservationEntry."Source Type" := Database::"Purchase Line";
        ReservationEntry."Source Subtype" := PurchLine."Document Type".AsInteger();
        ReservationEntry."Source ID" := PurchLine."Document No.";
        ReservationEntry."Source Ref. No." := PurchLine."Line No.";
        ReservationEntry."Expected Receipt Date" := PurchLine."Expected Receipt Date";
        ReservationEntry."Qty. per Unit of Measure" := PurchLine."Qty. per Unit of Measure";
        ReservationEntry.Validate("Lot No.", LotNo);
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry."Creation Date" := WorkDate();
        ReservationEntry."Created By" := UserId;
        ReservationEntry.Insert();
        CreateOrUpdateLotInfo(ReservationEntry);
    end;


    procedure ReservationExists(PurchLine: Record "Purchase Line"): Boolean
    var
        Res: Record "Reservation Entry";
    begin
        Res.SetRange("Source Type", Database::"Purchase Line");
        Res.SetRange("Source ID", PurchLine."Document No.");
        Res.SetRange("Source Ref. No.", PurchLine."Line No.");
        exit(Res.FindFirst());
    end;

    procedure CreateOrUpdateLotInfo(ResEntry: Record "Reservation Entry")
    begin
        if LotNoInfo.Get(ResEntry."Item No.", ResEntry."Variant Code", ResEntry."Lot No.") then
            exit;

        LotNoInfo.Init();
        LotNoInfo."Item No." := ResEntry."Item No.";
        LotNoInfo."Variant Code" := ResEntry."Variant Code";
        LotNoInfo."Lot No." := ResEntry."Lot No.";
        LotNoInfo.Description := ResEntry.Description;
        LotNoInfo.Insert();
    end;

    procedure GetNextEntryNo(): Integer
    var
        Res: Record "Reservation Entry";
    begin
        if LastEntryNo = 0 then
            if Res.FindLast() then
                LastEntryNo := Res."Entry No.";
        LastEntryNo += 1;
        exit(LastEntryNo);
    end;

    var
        ReservationEntry: Record "Reservation Entry";
        LotNoInfo: Record "Lot No. Information";
        Item: Record Item;
        NoSeriesMgt: Codeunit "No. Series";
        LastEntryNo: Integer;
}
