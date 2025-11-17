tableextension 50313 "Cust Ledger Entry Exe" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50302; "Field Test"; Text[50])
        {
            Caption = 'Field Test';
            DataClassification = ToBeClassified;
        }
        field(50303; "Field Testing"; Text[50])
        {
            Caption = 'Field Testing';
            DataClassification = ToBeClassified;
        }
    }
}
