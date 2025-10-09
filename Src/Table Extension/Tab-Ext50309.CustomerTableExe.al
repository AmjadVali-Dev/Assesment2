tableextension 50309 "CustomerTable Exe" extends Customer
{
    fields
    {
        field(50300; "Total Amount Sales "; Decimal)
        {
            Caption = 'Total Amount Sales ';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Amount where("Sell-to Customer No." = field("No.")));
        }
    }
}
