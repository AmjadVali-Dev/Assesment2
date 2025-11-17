tableextension 50316 "G/L Entry Exe" extends "G/L Entry"
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
