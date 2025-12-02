pageextension 50331 "Customer Exe" extends "Customer Card"
{

    layout
    {
        addlast(FactBoxes)
        {
            part(CustomerInvoices; "Customer Invoice FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No." = FIELD("No.");
            }
        }
    }
}
