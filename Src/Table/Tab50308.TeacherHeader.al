table 50308 "Teacher Header"
{
    Caption = 'Teacher Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Document Type Teacher")
        {
            Caption = 'Document Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Teacher No."; Code[20])
        {
            Caption = 'Teacher No.';
            TableRelation = "Master Table Teacher"."Teacher No.";
            trigger OnValidate()
            var
                MasterRec: Record "Master Table Teacher";
            begin
                if MasterRec.Get("Teacher No.") then begin
                    "Teacher Name" := MasterRec."Teacher Name";
                    Department := MasterRec.Department;
                end;
                Description := Rec."Teacher Name" + ' - Order Is Created';
            end;
        }
        field(4; "Teacher Name"; Text[50])
        {
            Caption = 'Teacher Name';
        }
        field(5; "Assainment Date"; Date)
        {
            Caption = 'Assainment Date';
        }
        field(6; Department; Code[20])
        {
            Caption = 'Department';
        }
        field(7; "Total Hours "; Decimal)
        {
            Caption = 'Total Hours ';
        }
        field(8; Status; Enum "Status Header")
        {
            Caption = 'Status';
        }
        field(9; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(11; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(12; "Invoice No."; Integer)
        {
            Caption = 'Invoice No.';
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        CodeunitRec: Codeunit "Reuisition No Gen";
    begin
        CodeunitRec.Teacher_No_Gen(Rec);
        if "Posting Date" = 0D then
            "Posting Date" := Today();

        if "Created By" = '' then
            "Created By" := UserId();
        if "Total Hours " = 0 then
            "Total Hours " := 8;
    end;
}
