table 50315 "Teacher Ledger Entry"
{
    Caption = 'Teacher Ledger Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Teacher No."; Code[20])
        {
            Caption = 'Teacher No.';
        }
        field(4; "Posting Date "; Date)
        {
            Caption = 'Posting Date ';
        }
        field(5; "Type"; Enum "Document Type Teacher")
        {
            Caption = 'Type';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
