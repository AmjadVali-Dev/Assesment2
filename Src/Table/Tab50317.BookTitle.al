table 50317 "Book Title"
{
    Caption = 'Book Title';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Title; Text[100])
        {
            Caption = 'Title';
        }
        field(2; "Book Genre"; Enum "Book Genre Enum")
        {
            Caption = 'Book Genre';

        }
    }
    keys
    {
        key(PK; Title, "Book Genre")
        {
            Clustered = true;
        }
    }
}
