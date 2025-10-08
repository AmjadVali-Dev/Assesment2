page 50308 "Employe Master"
{
    ApplicationArea = All;
    Caption = 'Employe Master';
    PageType = Card;
    SourceTable = "Employe Master";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name."; Rec."Employee Name.")
                {
                    ToolTip = 'Specifies the value of the Employee Name. field.', Comment = '%';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.', Comment = '%';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.', Comment = '%';
                }
                field("Employe Status"; Rec."Employe Status")
                {
                    ToolTip = 'Specifies the value of the Employe Status field.', Comment = '%';
                }
            }
        }
    }
}
