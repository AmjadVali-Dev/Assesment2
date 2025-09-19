tableextension 50303 "Purchase Receipt Line Exe" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50300; "Requisition No.A"; Code[20])
        {
            Caption = 'Requisition No.A';
            DataClassification = ToBeClassified;
        }
        field(50301; "Requisition Line No.A"; Integer)
        {
            Caption = 'Requisition Line No.A';
            DataClassification = ToBeClassified;
        }
    }
}
