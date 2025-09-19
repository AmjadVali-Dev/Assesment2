page 50300 "Purchase Requisition Order"
{
    ApplicationArea = All;
    Caption = 'Purchase Requisition Order';
    PageType = Card;
    SourceTable = "Purchase Requisition Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Released Time"; Rec."Released Time")
                {
                    ToolTip = 'Specifies the value of the Released Time field.', Comment = '%';
                }
            }
            part("Purchase Requisition Order Subform"; "Purchase Requisition Subform")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Release)
            {
                Caption = 'Release';
                ApplicationArea = All;
                Image = ReleaseDoc;
                trigger OnAction()
                var
                    ReqMgt: Codeunit "Requisation Management";
                begin
                    ReqMgt.ReleaseRequisition(Rec);
                end;
            }
        }
    }
}
