tableextension 50300 "Purchase & Payable Setup Exe" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50300; "Requisition Nos."; Code[10])
        {
            Caption = 'Requisition Nos.';
            TableRelation = "No. Series";
        }
    }
}
