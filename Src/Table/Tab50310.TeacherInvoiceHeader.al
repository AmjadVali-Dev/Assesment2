table 50310 "Teacher Invoice Header"
{
    Caption = 'Teacher Invoice Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Invoice No."; Integer)
        {
            Caption = 'Invoice No.';
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "Document Type"; Enum "Document Type Teacher")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(4; "Teacher No."; Code[20])
        {
            Caption = 'Teacher No.';
            Editable = false;
        }
        field(5; "Teacher Name"; Text[50])
        {
            Caption = 'Teacher Name';
            Editable = false;
        }
        field(6; "Total Hours Posted"; Decimal)
        {
            Caption = 'Total Hours Posted';
            Editable = false;
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(8; Department; Code[20])
        {
            Caption = 'Department';
            Editable = false;
        }
        field(9; Desription; Text[200])
        {
            Caption = 'Desription';
            Editable = false;
        }
        field(10; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(11; "Posted On"; DateTime)
        {
            Caption = 'Posted On';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Invoice No.")
        {
            Clustered = true;
        }
    }
}
