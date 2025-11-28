table 50312 "Subject Master Table"
{
    Caption = 'Subject Master Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
        }
        field(2; "Subject Name"; Text[50])
        {
            Caption = 'Subject Name';
        }
    }
    keys
    {
        key(PK; "Subject Code")
        {
            Clustered = true;
        }
    }
}
