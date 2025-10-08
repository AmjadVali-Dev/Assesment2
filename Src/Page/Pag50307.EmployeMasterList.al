page 50307 "Employe Master List"
{
    ApplicationArea = All;
    Caption = 'Employe Master List';
    PageType = List;
    SourceTable = "Employe Master";
    UsageCategory = Lists;
    CardPageId = "Employe Master";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
    trigger OnOpenPage()
    begin
        Rec.SetRange("Employe Status", Rec."Employe Status"::Active);
        Message('These Are The Employees With Active Status');
    end;
}
