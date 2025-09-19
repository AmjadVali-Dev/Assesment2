page 50303 "Purchase Requisition Subform"
{
    ApplicationArea = All;
    Caption = 'Purchase Requisition Subform';
    PageType = ListPart;
    SourceTable = "Purchase Requisition Line";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ToolTip = 'Specifies the value of the Requisition Date field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order No. field.', Comment = '%';
                }
                field("Purchase Order Line No."; Rec."Purchase Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Line No. field.', Comment = '%';
                }
            }
        }
    }
}
