table 50313 "Tacher Shipment Header"
{
    Caption = 'Tacher Shipment Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Shipment No."; Integer)
        {
            Caption = 'Shipment No.';
            AutoIncrement = true;
            Editable = false;
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
        field(6; Department; Code[20])
        {
            Caption = 'Department';
            Editable = false;
        }
        field(7; "Total Hours Shipped"; Decimal)
        {
            Caption = 'Total Hours Shipped';
            Editable = false;
        }
        field(8; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            Editable = false;
        }
        field(9; Description; Text[200])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(10; "Shipped By"; Code[20])
        {
            Caption = 'Shipped By';
            Editable = false;
        }
        field(11; "Shipped On"; DateTime)
        {
            Caption = 'Shipped On';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Shipment No.", "Document Type", "Document No.")
        {
            Clustered = true;
        }
    }
}
