table 50316 "Teacher XML Stats"
{
    Caption = 'Teacher XML Stats';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Last Export Date"; DateTime)
        {
            Caption = 'Last Export Date';
        }
        field(3; "Last Import Date"; DateTime)
        {
            Caption = 'Last Import Date';
        }
        field(4; "Total Teachers"; Integer)
        {
            Caption = 'Total Teachers';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
