pageextension 50305 "Item journal Line Exe" extends "Item Journal"
{
    layout
    {
        addafter("Item No.")
        {
            field("Reqiuisition No."; Rec."Reqiuisition No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reqiuisition No. field.', Comment = '%';
            }
            field("Requision Line No."; Rec."Requision Line No.A")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requision Line No. field.', Comment = '%';
            }
        }
    }
}
