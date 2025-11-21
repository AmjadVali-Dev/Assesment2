page 50322 "Teacher Order List"
{
    ApplicationArea = All;
    Caption = 'Teacher Order List';
    PageType = List;
    SourceTable = "Teacher Header";
    UsageCategory = Lists;
    CardPageId = "Teacher Order";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
            }
        }
    }
}
