table 50306 "Discount Details"
{
    Caption = 'Discount Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(2; "Discount Code"; Code[20])
        {
            Caption = 'Discount Code';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Discount Percent"; Decimal)
        {
            Caption = 'Discount Percent';
            DataClassification = CustomerContent;
        }
        field(5; "Valid From"; Date)
        {
            Caption = 'Valid From';
            DataClassification = CustomerContent;
        }
        field(6; "Valid To"; Date)
        {
            Caption = 'Valid To';
            DataClassification = CustomerContent;
        }
        field(7; AppliesTo; Option)
        {
            Caption = 'Applies To';
            OptionMembers = Item,Vendor,Customer,All;
            DataClassification = CustomerContent;
        }
        field(8; "Is Active"; Boolean)
        {
            Caption = 'Is Active';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Code; "Discount Code") { }
    }
}