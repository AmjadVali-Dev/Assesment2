codeunit 50307 "Item Finding Code Unit"
{
    procedure ShowCustomersForItem(ItemNo: Code[20])
    var
        SalesLineRec: Record "Sales Line";
        SalesHeaderRec: Record "Sales Header";
        CustomerRec: Record Customer;
    begin
        SalesLineRec.SetRange("No.", ItemNo);
        if SalesLineRec.FindSet() then begin
            repeat
                if SalesHeaderRec.Get(SalesLineRec."Document Type", SalesLineRec."Document No.") then begin
                    if CustomerRec.Get(SalesHeaderRec."Sell-to Customer No.") then begin
                        Message('Customer: %1, Order No: %2', CustomerRec.Name, SalesLineRec."Document No.");
                    end;
                end;
            until SalesLineRec.Next() = 0;
        end else
            Message('No sales found for Item %1', ItemNo);
    end;


    procedure ItemCount(ItemRec: Record Item)
    var
        SaleslineRec: Record "Sales Line";
        Count: Integer;
    begin
        SaleslineRec.SetRange("No.", ItemRec."No.");
        if SaleslineRec.FindSet() then begin
            repeat
                Count := Count + 1;
            until SaleslineRec.Next() = 0;
        end;
        Message('The count Of The Items %1', Count);
    end;
}
