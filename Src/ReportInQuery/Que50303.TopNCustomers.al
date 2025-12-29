query 50303 "Top N Customers"
{
    Caption = 'Top N Customers';
    QueryType = Normal;

    elements
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            { }
            column(Name; Name)
            { }
            column(BalanceLCY; "Balance (LCY)")
            {
            }
            column(City; City) { }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
