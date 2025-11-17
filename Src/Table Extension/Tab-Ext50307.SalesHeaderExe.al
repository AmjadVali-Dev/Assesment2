tableextension 50307 "Sales Header nExe" extends "Sales Header"
{
    fields
    {
        field(50300; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
        }
        field(50301; "Customer Name2"; Text[100])
        {
            Caption = 'Customer Name';

            trigger OnLookup()
            var
                CustRec: Record Customer;
            begin
                if Page.RunModal(Page::"Customer List", CustRec) = Action::LookupOK then begin
                    "Customer Name2" := CustRec.Name;
                    "Sell-to Customer No." := CustRec."No.";
                end;
            end;
        }
        field(50302; "Field Test"; Text[50])
        {
            Caption = 'Field Test';
            DataClassification = ToBeClassified;
        }

    }
}
