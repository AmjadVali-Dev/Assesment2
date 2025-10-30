pageextension 50315 "Sales Order List Exe" extends "Sales Order List"
{
    actions
    {
        addlast(Processing)
        {
            action("Get The Element using Particular")
            {
                ApplicationArea = All;
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Get The Element';
                trigger OnAction()
                var
                    SalesHeaderrec: Record "Sales Header";
                begin
                    if SalesHeaderrec.Get(SalesHeaderrec."Document Type"::Order, '101047') then
                        Message(SalesHeaderrec."Sell-to Customer No.")
                    else
                        Message('Record not found.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesHeaderRec: Record "Sales Header";
        RecRef: RecordRef;
    begin
        SalesHeaderRec.SetRange("Sell-to Customer No.", '10000');
        RecRef.SetTable(SalesHeaderRec);
        Message('Total Records for Sell-to Customer No. 10000: %1', RecRef.Count());
    end;
}
