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

    procedure NoGenE(var EmployeRec: Record "Employe Master")
    var
        NoSeries: Codeunit "No. Series";
        SalesandRece: Record "Sales & Receivables Setup";
    begin
        if EmployeRec."Employee No." = '' then begin
            SalesandRece.Get();
            SalesandRece.TestField("No.Gen");
            EmployeRec."Employee No." := NoSeries.GetNextNo(SalesandRece."No.Gen", Today(), true);
        end;
    end;

}
