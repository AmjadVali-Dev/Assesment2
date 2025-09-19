table 50300 "Purchase Requisition Header"
{
    Caption = 'Purchase Requisition Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Requisition Date"; Date)
        {
            Caption = 'Requisition Date';
        }
        field(3; Department; Enum "Department Type")
        {
            Caption = 'Department';
            trigger OnValidate()
            begin
                UpdateLines();
            end;
        }
        field(4; Purpose; Text[40])
        {
            Caption = 'Purpose';

        }
        field(5; Status; Enum "Status Enum")
        {
            Caption = 'Status';
        }
        field(6; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(7; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }
        field(8; "Created Time"; Time)
        {
            Caption = 'Created Time';
        }
        field(9; "Released By"; Code[50])
        {
            Caption = 'Released By';
        }
        field(10; "Released Date"; Date)
        {
            Caption = 'Released Date';
        }
        field(11; "Released Time"; Time)
        {
            Caption = 'Released Time';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeries: Codeunit "Reuisition No Gen";
        userSetupRec: Record "User Setup";
    begin
        NoSeries.No_Generator(Rec);
        "Requisition Date" := WorkDate();
        if userSetupRec.Get(UserId) then begin
            "Created By" := UserId;
            "Created Date" := Today;
            "Created Time" := Time;
            Department := userSetupRec.DepartmentA;
        end;
    end;

    trigger OnDelete()
    var
        PurchaseLineRec: Record "Purchase Requisition Line";
    begin
        if Rec.Status = Rec.Status::Open then begin
            if PurchaseLineRec.Get(Rec."No.") then
                PurchaseLineRec.DeleteAll();
        end else
            Error('The Order is Released. You cannot delete it.');
    end;

    procedure UpdateLines()
    var
        ReqLine: Record "Purchase Requisition Line";
    begin
        ReqLine.SetRange("No.", "No.");
        if ReqLine.FindSet() then
            repeat
                ReqLine.Department := Rec.Department;
                ReqLine."Requisition Date" := Rec."Requisition Date";
                ReqLine.Status := Rec.Status;
                ReqLine.Modify();
            until ReqLine.Next() = 0;
    end;
}
