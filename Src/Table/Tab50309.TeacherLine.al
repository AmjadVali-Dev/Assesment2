table 50309 "Teacher Line"
{
    Caption = 'Teacher Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Document Type Teacher")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code ';
            TableRelation = "Subject Master Table"."Subject Code";
            trigger OnValidate()
            var
                SubjectRec: Record "Subject Master Table";
            begin
                if SubjectRec.Get("Subject Code") then
                    "Subject Name" := SubjectRec."Subject Name";
            end;

        }
        field(5; "Subject Name"; Text[50])
        {
            Caption = 'Subject Name';
        }
        field(6; "Hours Assained"; Decimal)
        {
            Caption = 'Hours Assained';
            trigger OnValidate()
            begin
                if Rec."Hours Assained" > 8 then
                    Error('Please enter a value less than or equal to 8 hours');
            end;
        }
        field(7; "Class Date"; Date)
        {
            Caption = 'Class Date';
        }
        field(8; "Room No."; Code[20])
        {
            Caption = 'Room No.';
        }
        field(9; Remarks; Text[200])
        {
            Caption = 'Remarks';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        TeacherLine: Record "Teacher Line";
        TeacherHeaderRec: Record "Teacher Header";
    begin
        TeacherLine.SetRange("Document No.", "Document No.");
        if TeacherLine.FindLast() then
            "Line No." := TeacherLine."Line No." + 10000
        else
            "Line No." := 10000;
        "Class Date" := Today();
        if TeacherHeaderRec.Get("Document Type", "Document No.") then
            Remarks := 'Assigned to ' + TeacherHeaderRec."Teacher Name" + ' for the selected subject.';
    end;
}
