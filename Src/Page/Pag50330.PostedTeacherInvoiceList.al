page 50330 "Posted Teacher Invoice List"
{
    ApplicationArea = All;
    Caption = 'Posted Teacher Invoice List';
    PageType = List;
    SourceTable = "Teacher Invoice Header";
    UsageCategory = Lists;
    CardPageId = "Posted Invoice Order";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
        }
    }
}
