table 50350 "Library Book Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Book ID"; Code[20])
        {
            Caption = 'Book ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Book Title"; Text[100])
        {
            Caption = 'Book Title';
            DataClassification = ToBeClassified;
        }
        field(3; "Author Name"; Text[100])
        {
            Caption = 'Author Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Published Year"; Integer)
        {
            Caption = 'Published Year';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Book ID")
        {
            Clustered = true;
        }
    }
    //create a trigger oninsert to auto instert authour name as 'Amjad'
    trigger OnInsert()
    begin
        Rec."Author Name" := 'Amjad';
    end;
}
