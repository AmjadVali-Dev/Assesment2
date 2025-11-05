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
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", CustomerRec."No.");
        if SalesHeader.FindSet() then
            repeat
                TotalAmount += SalesHeader.Amount;
            until SalesHeader.Next() = 0;

        Message('Total sales orders amount for customer %1: %2', CustomerRec."No.", TotalAmount);
        exit(TotalAmount);
    end;
}
