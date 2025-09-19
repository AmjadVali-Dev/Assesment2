pageextension 50309 "Sales Order Exe" extends "Sales Order"
{
    layout
    {
        addlast(content)
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
            }
            field("Customer Name2"; Rec."Customer Name2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
            }
        }
    }
}
