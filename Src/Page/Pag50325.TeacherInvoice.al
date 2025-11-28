page 50325 "Teacher Invoice"
{
    ApplicationArea = All;
    Caption = 'Teacher Invoice';
    PageType = Card;
    SourceTable = "Teacher Header";

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
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.', Comment = '%';
                }
            }
            part("Teacher Invoice Order Subform"; "Teacher Invoice Order Subform")
            {
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PostInvoice)
            {
                Caption = 'Post Invoice';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PostingMgt: Codeunit "Teacher Posting Mgt";
                begin
                    PostingMgt.PostTeacherHeader(Rec);
                    Message('Teacher Invoice Posted Successfully.');
                end;
            }
        }
    }
}
