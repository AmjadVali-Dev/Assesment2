page 50301 "Purchse Requisition Order List"
{
    ApplicationArea = All;
    Caption = 'Purchse Requisition Order List';
    PageType = List;
    SourceTable = "Purchase Requisition Header";
    UsageCategory = Lists;
    CardPageId = "Purchase Requisition Order";
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
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ToolTip = 'Specifies the value of the Requisition Date field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.', Comment = '%';
                }
                field("Created Time"; Rec."Created Time")
                {
                    ToolTip = 'Specifies the value of the Created Time field.', Comment = '%';
                }
                field("Released By"; Rec."Released By")
                {
                    ToolTip = 'Specifies the value of the Released By field.', Comment = '%';
                }
                field("Released Date"; Rec."Released Date")
                {
                    ToolTip = 'Specifies the value of the Released Date field.', Comment = '%';
                }
            }
        }
    }
}
