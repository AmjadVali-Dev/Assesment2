codeunit 50302 DeleteNote
{
    procedure DeleteNotes(CustomerRec: Record Customer)
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.SetRange("Record ID", CustomerRec.RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);

        if RecordLink.FindSet() then begin
            repeat
                RecordLink.Delete();
            until RecordLink.Next() = 0;
            Message('All notes deleted for customer %1', CustomerRec."No.");
        end else
            Message('No notes found for customer %1', CustomerRec."No.");
    end;


    procedure CalculateTotalSalesOrders(CustomerRec: Record Customer): Decimal
    var
        SalesHeader: Record "Sales Header";
        Count: Decimal;
    begin
        Count := 0;
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", CustomerRec."No.");
        if SalesHeader.FindSet() then
            repeat
                Count := Count + 1;
            until SalesHeader.Next() = 0;

        Message('Total sales orders amount for customer %1: %2', CustomerRec."No.", Count);
        exit(Count);
    end;


    procedure FindingCustomer(SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        if Customer.Get(SalesHeader."Sell-to Customer No.") then Begin
            Message(Customer.Name);
        End
    end;
}
