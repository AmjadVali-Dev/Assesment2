tableextension 50305 "Item Journal Line Exe" extends "Item Journal Line"
{
    fields
    {
        field(50300; "Reqiuisition No.A"; Code[20])
        {
            Caption = 'Reqiuisition No.A';
            DataClassification = ToBeClassified;
        }
        field(50301; "Requision Line No.A"; Integer)
        {
            Caption = 'Requision Line No.A';
            DataClassification = ToBeClassified;
        }
    }
}
