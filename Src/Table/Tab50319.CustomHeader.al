table 50319 "Custom Header"
{
    Caption = 'Custom Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Status"; Enum "Custom Doc Status")
        {
            Caption = 'Status';
        }
        field(4; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(5; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoGenCodeunit: Codeunit "Reuisition No Gen";
    begin
        NoGenCodeunit.Custom_No_Gen(Rec);
        Description := 'New Custom Order' + '-' + Rec."No.";
        "Created By" := UserId;
        "Created Date" := Today;
    end;
}
