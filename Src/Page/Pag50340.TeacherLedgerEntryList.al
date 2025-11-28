page 50340 "Teacher Ledger Entry List"
{
    ApplicationArea = All;
    Caption = 'Teacher Ledger Entry List';
    PageType = List;
    SourceTable = "Teacher Ledger Entry";
    UsageCategory = Lists;
    CardPageId = "Teacher Ledger Entry";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Teacher No."; Rec."Teacher No.")
                {
                    ToolTip = 'Specifies the value of the Teacher No. field.', Comment = '%';
                }
                field("Posting Date "; Rec."Posting Date ")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
            }
        }
    }
}
