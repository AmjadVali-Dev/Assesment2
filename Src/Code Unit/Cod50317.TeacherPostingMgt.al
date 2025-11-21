codeunit 50317 "Teacher Posting Mgt"
{
    procedure PostTeacherHeader(var TeacherHeader: Record "Teacher Header")
    var
        InvoiceHeader: Record "Teacher Invoice Header";
        InvoiceLine: Record "Teacher Invoice Line";
        TeacherLine: Record "Teacher Line";
        NextLineNo: Integer;
        OpenPage: Boolean;
    begin
        InvoiceHeader.Init();
        InvoiceHeader."Document Type" := TeacherHeader."Document Type"::Invoice;
        InvoiceHeader."Document No." := TeacherHeader."No.";
        InvoiceHeader."Teacher No." := TeacherHeader."Teacher No.";
        InvoiceHeader."Teacher Name" := TeacherHeader."Teacher Name";
        InvoiceHeader.Department := TeacherHeader.Department;
        InvoiceHeader."Total Hours Posted" := TeacherHeader."Total Hours ";
        InvoiceHeader."Posting Date" := Today();
        InvoiceHeader.Desription := TeacherHeader.Description;
        InvoiceHeader."Posted By" := UserId();
        InvoiceHeader."Posted On" := CurrentDateTime();
        InvoiceHeader.Insert(true);

        TeacherLine.Reset();
        TeacherLine.SetRange("Document Type", TeacherHeader."Document Type");
        TeacherLine.SetRange("Document No.", TeacherHeader."No.");
        if TeacherLine.FindSet() then begin
            NextLineNo := 10000;
            repeat
                InvoiceLine.Init();
                InvoiceLine."Document Type" := TeacherLine."Document Type"::Invoice;
                InvoiceLine."Document No." := TeacherLine."Document No.";
                InvoiceLine."Line No" := NextLineNo;
                InvoiceLine."Subject Code" := TeacherLine."Subject Code ";
                InvoiceLine."Subject Name" := TeacherLine."Subject Name";
                InvoiceLine."Hours Assained" := TeacherLine."Hours Assained";
                InvoiceLine."Class Date" := TeacherLine."Class Date";
                InvoiceLine."Room No" := TeacherLine."Room No.";
                InvoiceLine.Remarks := TeacherLine.Remarks;
                InvoiceLine.Insert(true);
                NextLineNo += 10000;
            until TeacherLine.Next() = 0;
        end;

        TeacherHeader.Status := TeacherHeader.Status::Posted;
        TeacherHeader.Modify(true);

        OpenPage := Confirm('Posting completed.\Do you want to open the posted invoice?', false);
        if OpenPage then
            Page.Run(Page::"Posted Invoice Order", InvoiceHeader);
    end;


    procedure PostTeacherShipment(var TeacherHeader: Record "Teacher Header")
    var
        ShipmentHeader: Record "Tacher Shipment Header";
        ShipmentLine: Record "Teacher Shipment Line";
        TeacherLine: Record "Teacher Line";
        NextLineNo: Integer;
        OpenPage: Boolean;
    begin

        ShipmentHeader.Init();
        ShipmentHeader."Document Type" := TeacherHeader."Document Type"::Shipment;
        ShipmentHeader."Document No." := TeacherHeader."No.";
        ShipmentHeader."Teacher No." := TeacherHeader."Teacher No.";
        ShipmentHeader."Teacher Name" := TeacherHeader."Teacher Name";
        ShipmentHeader.Department := TeacherHeader.Department;
        ShipmentHeader."Total Hours Shipped" := TeacherHeader."Total Hours ";
        ShipmentHeader."Shipment Date" := Today();
        ShipmentHeader.Description := TeacherHeader.Description;
        ShipmentHeader."Shipped By" := UserId();
        ShipmentHeader."Shipped On" := CurrentDateTime();
        ShipmentHeader.Insert(true);

        TeacherLine.Reset();
        TeacherLine.SetRange("Document Type", TeacherHeader."Document Type");
        TeacherLine.SetRange("Document No.", TeacherHeader."No.");
        if TeacherLine.FindSet() then begin
            NextLineNo := 10000;
            repeat
                ShipmentLine.Init();
                ShipmentLine."Document Type" := TeacherLine."Document Type"::Shipment;
                ShipmentLine."Document No." := TeacherLine."Document No.";
                ShipmentLine."Line No." := NextLineNo;

                ShipmentLine."Subject Code" := TeacherLine."Subject Code ";
                ShipmentLine."Subject Name" := TeacherLine."Subject Name";
                ShipmentLine."Hours Shipped" := TeacherLine."Hours Assained";
                ShipmentLine."Class Date" := TeacherLine."Class Date";
                ShipmentLine."Room No" := TeacherLine."Room No.";
                ShipmentLine.Remarks := TeacherLine.Remarks;

                ShipmentLine.Insert(true);
                NextLineNo += 10000;
            until TeacherLine.Next() = 0;
        end;
        TeacherHeader.Status := TeacherHeader.Status::Shipped;
        TeacherHeader.Modify(true);
        OpenPage := Confirm('Shipment posted successfully.\Do you want to open the posted shipment?', false);

        if OpenPage then
            Page.Run(Page::"Teacher Shipment", ShipmentHeader);
    end;
}
