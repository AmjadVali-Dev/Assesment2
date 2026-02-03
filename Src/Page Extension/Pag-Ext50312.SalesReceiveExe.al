pageextension 50312 "Sales & Receive Exe" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(content)
        {
            field("No.Gen"; Rec."No.Gen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No.Gen field.', Comment = '%';
            }
            field("Teacher No. Gen"; Rec."Teacher No. Gen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Teacher No. Gen field.', Comment = '%';
            }
            field("INvoice No. Gen"; Rec."INvoice No. Gen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice No. Gen field.', Comment = '%';
            }
            field("Shipment No. Gen"; Rec."Shipment No. Gen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipment No. Gen field.', Comment = '%';
            }
            field("Custom No. Gen"; Rec."Custom No. Gen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Custom No. Gen field.', Comment = '%';
            }

        }
    }
}
