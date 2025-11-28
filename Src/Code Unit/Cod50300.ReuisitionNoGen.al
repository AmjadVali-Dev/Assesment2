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

    procedure Teacher_No_Gen(var TeacherHeader: Record "Teacher Header")
    var
        NoSeriesRec: Codeunit "No. Series";
        SalesandReceive: Record "Sales & Receivables Setup";
    begin
        if TeacherHeader."No." = '' then begin
            SalesandReceive.Get();
            SalesandReceive.TestField("Teacher No. Gen");
            TeacherHeader."No." := NoSeriesRec.GetNextNo(SalesandReceive."Teacher No. Gen", Today(), true);
        end;
    end;

    procedure Shipment_No_Gen(var ShipmentHeader: Record "Tacher Shipment Header")
    var
        NoSeriesRec: Codeunit "No. Series";
        SalesandReceive: Record "Sales & Receivables Setup";
    begin
        if ShipmentHeader."Document No." = '' then begin
            SalesandReceive.Get();
            SalesandReceive.TestField("Shipment No. Gen");
            ShipmentHeader."Document No." := NoSeriesRec.GetNextNo(SalesandReceive."Shipment No. Gen", Today(), true);
        end;
    end;

    procedure Invoice_No_Gen(var InvoiceHeader: Record "Teacher Invoice Header")
    var
        NoSeriesRec: Codeunit "No. Series";
        SalesandReceive: Record "Sales & Receivables Setup";
    begin
        if InvoiceHeader."Document No." = '' then begin
            SalesandReceive.Get();
            SalesandReceive.TestField("INvoice No. Gen");
            InvoiceHeader."Document No." := NoSeriesRec.GetNextNo(SalesandReceive."INvoice No. Gen", Today(), true);
        end;
    end;


}
