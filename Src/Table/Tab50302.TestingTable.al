table 50302 "Testing Table"
{
    Caption = 'Testing Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            trigger OnLookup()
            var
                Currpage: Page "Customer List";
                CustomerRec: Record Customer;
            begin

            end;
        }
    }
    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }
    }
}
