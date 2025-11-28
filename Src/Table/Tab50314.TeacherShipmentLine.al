table 50314 "Teacher Shipment Line"
{
    Caption = 'Teacher Shipment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Document Type Teacher")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            Editable = false;
        }
        field(5; "Subject Name"; Text[50])
        {
            Caption = 'Subject Name';
            Editable = false;
        }
        field(6; "Hours Shipped"; Decimal)
        {
            Caption = 'Hours Shipped';
            Editable = false;
        }
        field(7; "Class Date"; Date)
        {
            Caption = 'Class Date';
            Editable = false;
        }
        field(8; "Room No"; Code[20])
        {
            Caption = 'Room No';
            Editable = false;
        }
        field(9; Remarks; Text[200])
        {
            Caption = 'Remarks';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
