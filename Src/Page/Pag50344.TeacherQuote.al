page 50344 "Teacher Quote"
{
    ApplicationArea = All;
    Caption = 'Teacher Quote';
    PageType = Document;
    SourceTable = "Teacher Header";
    SourceTableView = where("Document Type" = filter(Quote));
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Teacher No."; Rec."Teacher No.")
                {
                    ToolTip = 'Specifies the value of the Teacher No. field.', Comment = '%';
                }
                field("Teacher Name"; Rec."Teacher Name")
                {
                    ToolTip = 'Specifies the value of the Teacher Name field.', Comment = '%';
                }
                field("Assainment Date"; Rec."Assainment Date")
                {
                    ToolTip = 'Specifies the value of the Assainment Date field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Total Hours "; Rec."Total Hours ")
                {
                    ToolTip = 'Specifies the value of the Total Hours field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Approved On"; Rec."Approved On")
                {
                    ToolTip = 'Specifies the value of the Approved On field.', Comment = '%';
                }
            }
            part("Teacher Quote Order Subform"; "Teacher Quote Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Convert Into Order")
            {
                ApplicationArea = All;
                Image = Order;
                Caption = 'Convert Into Order';
                trigger OnAction()
                var
                    CodeunitRec: Codeunit "Teacher Quote Mgmt";
                    NewOrder: Record "Teacher Header";
                begin
                    CodeunitRec.ConvertQuoteToOrder(Rec);
                end;
            }
        }
    }
}
