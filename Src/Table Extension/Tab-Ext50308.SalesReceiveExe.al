tableextension 50308 "Sales & Receive Exe" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50300; "No.Gen"; Code[20])
        {
            Caption = 'No.Gen';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50301; "Teacher No. Gen"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'Teacher No. Gen';
            DataClassification = ToBeClassified;
        }
    }
}
