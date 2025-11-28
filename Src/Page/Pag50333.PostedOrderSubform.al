page 50333 "Posted Order Subform"
{
    ApplicationArea = All;
    Caption = 'Posted Order Subform';
    PageType = ListPart;
    SourceTable = "Teacher Invoice Line";

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
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Line No"; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.', Comment = '%';
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ToolTip = 'Specifies the value of the Subject Code field.', Comment = '%';
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ToolTip = 'Specifies the value of the Subject Name field.', Comment = '%';
                }
                field("Hours Assained"; Rec."Hours Assained")
                {
                    ToolTip = 'Specifies the value of the Hours Assained field.', Comment = '%';
                }
                field("Class Date"; Rec."Class Date")
                {
                    ToolTip = 'Specifies the value of the Class Date field.', Comment = '%';
                }
                field("Room No"; Rec."Room No")
                {
                    ToolTip = 'Specifies the value of the Room No field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
            }
        }
    }
}
