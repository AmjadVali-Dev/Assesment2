page 50304 "ReleasePurchase Req"
{
    ApplicationArea = All;
    Caption = 'Release Purchase Req';
    PageType = List;
    SourceTable = "Purchase Requisition Header";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Status = filter(Released));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Created Time"; Rec."Created Time")
                {
                    ToolTip = 'Specifies the value of the Created Time field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field("Released By"; Rec."Released By")
                {
                    ToolTip = 'Specifies the value of the Released By field.';
                }
                field("Released Date"; Rec."Released Date")
                {
                    ToolTip = 'Specifies the value of the Released Date field.';
                }
                field("Released Time"; Rec."Released Time")
                {
                    ToolTip = 'Specifies the value of the Released Time field.';
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ToolTip = 'Specifies the value of the Requisition Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
