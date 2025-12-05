table 50308 "Teacher Header"
{
    Caption = 'Teacher Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Subject Master List";
    DrillDownPageId = "Subject Master List";
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
                Length: Integer;
                FirstFive: Text[10];
                Deletedletters: Text[10];
                InsertedText: Text[50];
            begin
                if MasterRec.Get("Teacher No.") then begin
                    "Teacher Name" := MasterRec."Teacher Name";
                    Department := MasterRec.Department;
                    // Length := StrLen((MasterRec."Teacher Name"));
                    // if Length > 20 then
                    //     Error('Teacher Name Leangth Exceeds 20 Characters. Please Update Teacher Name in Master Table Teacher')
                    // else
                    //     Message('Teacher Name Length is Valid with %1 Characters', Length);
                    // FirstFive := CopyStr(MasterRec."Teacher Name", 1, 5);
                    // Message('First Five Characters of Teacher Name: %1', FirstFive);
                    // Deletedletters := DelStr(MasterRec."Teacher Name", 3, 4);
                    // Message('Teacher Name After Deleting Characters From Position 3 to 4: %1', Deletedletters);
                    // InsertedText := InsStr(MasterRec."Teacher Name", ' - TEACHER', Length + 1);
                    // Message('Teacher Name After Inserting Text at the End: %1', InsertedText);
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
        field(13; "Approval Status"; Enum "Teacher Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
        }

        field(14; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
        }

        field(15; "Approved On"; DateTime)
        {
            Caption = 'Approved On';
            Editable = false;
        }
        field(16; "Teacher Image"; BLOB)
        {
            Caption = 'Teacher Image';
            SubType = Bitmap;
        }
        field(17; "Teacher Photo"; Media)
        {
            Caption = 'Teacher Photo';
        }
        field(18; "Total Hours2"; Decimal)
        {
            Caption = 'Total Hours2';
            FieldClass = FlowField;
            CalcFormula = sum("Teacher Line"."Hours Assained" where("Document Type" = filter(Assignment), "Document No." = field("No.")));
        }
        field(19; "Is Assigned"; Boolean)
        {
            Caption = 'Is Assigned';
            Editable = false;
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

    procedure UpdateTotalHoursFromLines()
    var
        TeacherLineRec: Record "Teacher Line";
        HoursTotal: Decimal;
    begin
        HoursTotal := 0;

        TeacherLineRec.SetRange("Document Type", "Document Type");
        TeacherLineRec.SetRange("Document No.", "No.");

        if TeacherLineRec.FindSet() then
            repeat
                HoursTotal += TeacherLineRec."Hours Assained";
            until TeacherLineRec.Next() = 0;

        "Total Hours " := HoursTotal;
    end;

    procedure UpdateAssignmentStatus()
    var
        LineRec: Record "Teacher Line";
    begin
        LineRec.Reset();
        LineRec.SetRange("Document No.", "No.");
        LineRec.SetRange("Document Type", "Document Type");

        if LineRec.FindFirst() then begin
            "Is Assigned" := true;
            Rec.Modify();
        end else begin
            "Is Assigned" := false;
            Rec.Modify();
        end;
    end;

}
