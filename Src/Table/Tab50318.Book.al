table 50318 Book
{
    Caption = 'Book';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Book ID"; Integer)
        {
            Caption = 'Book ID';
        }
        field(2; "Book Publisher"; Text[100])
        {
            Caption = 'Book Publisher';
        }
        field(3; "Book Title"; Text[100])
        {
            Caption = 'Book Title';
            TableRelation = "Book Title".Title where("Book Genre" = field("Book Genre"));
        }
        field(4; "Book Genre"; Enum "Book Genre Enum")
        {
            Caption = 'Book Genre';
        }
    }
    keys
    {
        key(PK; "Book ID")
        {
            Clustered = true;
        }
    }
}
