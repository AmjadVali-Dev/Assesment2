query 50301 "Top 3 Customers"
{
    Caption = 'Top 3 Customers';
    QueryType = Normal;
    TopNumberOfRows = 3;
    QueryCategory = 'Customer List';
    OrderBy = descending(SalesLCY);

    elements
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            filter(PostingDate; "Posting Date")
            {
            }

            column(CustomerNo; "Customer No.")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }

            column(SalesLCY; "Sales (LCY)")
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        currQuery.SetRange(PostingDate, DMY2Date(1, 1, 2025), Today);
    end;
}
