page 50331 "Posted Invoice Order"
{
    ApplicationArea = All;
    Caption = 'Posted Invoice Order';
    PageType = Document;
    SourceTable = "Teacher Invoice Header";
    SourceTableView = where("Document Type" = filter(Invoice));
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Teacher No."; Rec."Teacher No.")
                {
                    ToolTip = 'Specifies the value of the Teacher No. field.', Comment = '%';
                }
                field("Teacher Name"; Rec."Teacher Name")
                {
                    ToolTip = 'Specifies the value of the Teacher Name field.', Comment = '%';
                }
                field("Total Hours Posted"; Rec."Total Hours Posted")
                {
                    ToolTip = 'Specifies the value of the Total Hours Posted field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Desription; Rec.Desription)
                {
                    ToolTip = 'Specifies the value of the Desription field.', Comment = '%';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.', Comment = '%';
                }
                field("Posted On"; Rec."Posted On")
                {
                    ToolTip = 'Specifies the value of the Posted On field.', Comment = '%';
                }
            }
            part("Posted Invoice Order Subform"; "Posted Order Subform")
            {
                SubPageLink = "Document No." = field("Document No."), "Document Type" = field("Document Type");
                ApplicationArea = All;
            }
        }
    }
}
