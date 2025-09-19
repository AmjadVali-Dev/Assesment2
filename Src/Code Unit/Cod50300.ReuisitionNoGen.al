codeunit 50300 "Reuisition No Gen"
{
    procedure No_Generator(var Requisition: Record "Purchase Requisition Header")
    var
        NoSeries: Codeunit "No. Series";
        PurchasePaySetup: Record "Purchases & Payables Setup";
    begin
        if Requisition."No." = '' then begin
            PurchasePaySetup.Get();
            PurchasePaySetup.TestField("Requisition Nos.");
            Requisition."No." := NoSeries.GetNextNo(PurchasePaySetup."Requisition Nos.", Today(), true);
        end;
    end;
}
