tableextension 50306 "Item ledger Entry Exe" extends "Item Ledger Entry"
{
    fields
    {
        field(50300; "Requisition No.S"; Code[20])
        {
            Caption = 'Requisition No.S';
            DataClassification = ToBeClassified;
        }
        field(50301; "Requisition Line No.S"; Integer)
        {
            Caption = 'Requisition Line No.S';
            DataClassification = ToBeClassified;
        }
    }
}
