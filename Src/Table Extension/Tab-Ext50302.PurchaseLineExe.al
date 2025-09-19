tableextension 50302 "Purchase Line Exe" extends "Purchase Line"
{
    fields
    {
        field(50300; "Requisition No.A"; Code[20])
        {
            Caption = 'Requisition No.';
            DataClassification = ToBeClassified;
        }
        field(50301; "Requisition Line No.A"; Integer)
        {
            Caption = 'Requisition Line No.';
            DataClassification = ToBeClassified;
        }
    }
}
