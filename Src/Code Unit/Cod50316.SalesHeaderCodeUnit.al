codeunit 50316 "Sales Header Code Unit"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, "Sell-to Customer No.", false, false)]
    procedure OnAfterValidateEvent(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        Customerrec: Record Customer;
    begin
        if Customerrec.Get(Rec."Sell-to Customer No.") then begin
            Rec."Cust Name" := Customerrec.Name;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, 'Sell-to Customer No.', false, false)]
    local procedure BlockCustomerSelection(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        Cust: Record Customer;
    begin
        if Cust.Get(Rec."Sell-to Customer No.") then begin
            if Cust.Blocked <> Cust.Blocked::" " then begin
                Error(
                    'This customer (%1) is blocked (%2). You cannot use this customer in Sales Orders.',
                    Cust."No.",
                    Format(Cust.Blocked));
            end;
        end;
    end;
}
