query 50300 "List Of Customers"
{
    Caption = 'List Of Customers';
    QueryType = Normal;
    QueryCategory = 'Customer List';
    elements
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Balance; Balance)
            {
            }
            column(City; City)
            {
            }
            column(Contact; Contact)
            {
            }
            column(Image; Image)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
