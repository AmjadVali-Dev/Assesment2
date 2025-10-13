codeunit 50312 "Sales Order Creation"
{
    procedure CreateSalesOrderFromCustomer()
    var
        CustRec: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustomerPage: Page "Customer List";
    begin
        if Page.RunModal(Page::"Customer List", CustRec) = Action::LookupOK then begin
            SalesHeader.Init();
            SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.Validate("Sell-to Customer No.", CustRec."No.");
            SalesHeader.Validate("Sell-to Customer Name", CustRec.Name);
            SalesHeader.Validate("Posting Date", Today());
            SalesHeader.Insert(true);
            if InsertDefaultSalesLine(SalesHeader) then
                Message('Sales Order %1 created successfully for Customer %2.', SalesHeader."No.", CustRec.Name);
        end;
    end;

    procedure InsertDefaultSalesLine(SalesHeader: Record "Sales Header"): Boolean
    var
        ItemRec: Record Item;
        SalesLine: Record "Sales Line";
    begin
        if ItemRec.FindFirst() then begin
            repeat
                if not ItemRec.Blocked then begin
                    SalesLine.Init();
                    SalesLine.Validate("Document Type", SalesHeader."Document Type");
                    SalesLine.Validate("Document No.", SalesHeader."No.");
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    SalesLine.Validate("No.", ItemRec."No.");
                    SalesLine.Validate(Quantity, 1);
                    SalesLine.Validate("Unit Price", ItemRec."Unit Price");
                    SalesLine.Insert(true);
                    exit(true);
                end;
            until ItemRec.Next() = 0;
        end;
    end;
}
