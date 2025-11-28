table 50307 "Master Table Teacher"
{
    Caption = 'Master Table Teacher';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Teacher No."; Code[20])
        {
            Caption = 'Teacher No.';
        }
        field(2; "Teacher Name"; Text[50])
        {
            Caption = 'Teacher Name';
        }
        field(3; "Phone No."; Text[50])
        {
            Caption = 'Phone No.';
        }
        field(4; Email; Text[50])
        {
            Caption = 'Email';
        }
        field(5; Department; Code[20])
        {
            Caption = 'Department';
        }
        field(6; "Joining Date"; Date)
        {
            Caption = 'Joining Date';
        }
        field(7; Status; Enum "Status Master")
        {
            Caption = 'Status';
        }
        field(8; Address; Text[200])
        {
            Caption = 'Address';
        }
        field(9; City; Text[50])
        {
            Caption = 'City';
        }
        field(10; State; Text[50])
        {
            Caption = 'State';
        }
        field(11; "No. of Orders"; Integer)
        {
            Caption = 'No.of Orders';
            FieldClass = FlowField;
            CalcFormula = Count("Teacher Header" WHERE("Teacher No." = FIELD("Teacher No."), "Document Type" = FILTER(Assignment)));

        }

    }
    keys
    {
        key(PK; "Teacher No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Joining Date" := Today;
    end;
}
