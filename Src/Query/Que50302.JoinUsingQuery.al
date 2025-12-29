query 50302 "Join Using Query"
{
    Caption = 'Join Using Query';
    QueryType = Normal;
    OrderBy = descending(Quantity);
    QueryCategory = 'Customer List';

    elements
    {
        dataitem(Cus; Customer)
        {

            column(CustNo; "No.")
            {
            }
            column(CustName; Name)
            {

            }
            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Sell-to Customer No." = Cus."No.";
                SqlJoinType = InnerJoin;

                column(Quantity; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}