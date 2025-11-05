page 50319 "Discount Card"
{
    ApplicationArea = All;
    Caption = 'Discount Card';
    PageType = Card;
    SourceTable = "Discount Details";
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; Editable = false; }
                field("Discount Code"; Rec."Discount Code") { ApplicationArea = All; }
                field("Description"; Rec.Description) { ApplicationArea = All; }
                field("Discount Percent"; Rec."Discount Percent") { ApplicationArea = All; }
                field("Valid From"; Rec."Valid From") { ApplicationArea = All; }
                field("Valid To"; Rec."Valid To") { ApplicationArea = All; }
                field("Applies To"; Rec.AppliesTo) { ApplicationArea = All; }
                field("Is Active"; Rec."Is Active") { ApplicationArea = All; }
            }
        }
    }
}
